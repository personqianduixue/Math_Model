/**************************************************************
 * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 *
 * File: contains all the supporting code for a standalone C or mex for
 *       Regression RF. 
 * Copied all the code from the randomForest 4.5-28 or was it -29?
 * 
 * important changes (other than the many commented out printf's)
 * 1. Added function to print up parameter values
 * 2. emulated all R calls. so instead of S_alloc, used calloc
 * 3. checked with valgrind so that memory is not lost
 * 4. substituted random number generator from R's to mersenne twister from
 *    Matsumoto et al and Shawn Cokus.
 * 5. Instead of allocating and deallocating memory every time for findBestSplit
 *    and regTree, used two globals with prefix in_<funcname()>, where funcname
 *    are the aforementioned functions; so that the globals are set to 0 initially
 *    and then when the function is called for the first time they are set to 1 
 *    and memory is allocated in static variables (which stays put even if function 
 *    exits) and when ending the program the functions are called (dummy call which
 *    only does deallocation) with setting the globals to -99 which says to
 *    dellocate and exit
 * 6. A minor change to decrease the memory footprint was to use NODESTATUS as 
 *    a Char rather than an Int which shouldn't change any of the logic
 * 7. Other changes include compounding all the functions required into this
 *    single file reg_RF.cpp and adding this comment.
 *
 *************************************************************/

/*******************************************************************
 * Copyright (C) 2001-7 Leo Breiman, Adele Cutler and Merck & Co., Inc.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *******************************************************************/

/******************************************************************
 * buildtree and findbestsplit routines translated from Leo's
 * original Fortran code.
 *
 *      copyright 1999 by leo Breiman
 *      this is free software and can be used for any purpose.
 *      It comes with no guarantee.
 *
 ******************************************************************/
#define NODE_TERMINAL -1
#define NODE_TOSPLIT  -2
#define NODE_INTERIOR -3
#define NULL 0

#include "memory.h"
#include "stdio.h"
#include "math.h"
#include "time.h"
#include "stdlib.h"
#include "qsort.c"
#include "reg_RF.h"
#define swapInt(a, b) ((a ^= b), (b ^= a), (a ^= b))

#define INT_SMALL

#define MAX_UINT_COKUS 4294967295  //basically 2^32-1

//Global to  handle mem in findBestSplit
int in_findBestSplit=0; // 0 -initialize and normal.  1-normal  , -99 release
int in_regTree=0; //// 0 -initialize and normal.  1-normal  , -99 release

//cruft emulating rand() routinges from R. keep it
void GetRNGstate(){}
void PutRNGstate(){}



double unif_rand(){
    //double value=((double)rand())/RAND_MAX;
    //mexPrintf("%f, RAND_MAX %d\n", value, RAND_MAX);
    //return value;
	//return ((double)rand())/RAND_MAX;
    return (((double)randomMT())/((double)MAX_UINT_COKUS));
}
void zeroSMALLInt(void *x, int length) {
    memset(x, 0, length * sizeof(SMALL_INT));
}
void zeroInt(int *x, int length) {
    memset(x, 0, length * sizeof(int));
}

void zeroDouble(double *x, int length) {
    memset(x, 0, length * sizeof(double));
}

int imax2(int x, int y) {
    return (x < y) ? y : x;
}


int pack(int nBits, int *bits) {
    int i = nBits, pack = 0;
    while (--i >= 0) pack += bits[i] << i;
    return(pack);
}

void unpack(unsigned int pack, int *bits) {
    /* pack is a 4-byte integer.  The sub. returns icat, an integer array of
   zeroes and ones corresponding to the coefficients in the binary expansion
   of pack. */
    int i;
    for (i = 0; pack != 0; pack >>= 1, ++i) bits[i] = pack & 1;
}

/* Compute proximity. */
void computeProximity(double *prox, int oobprox, int *node, int *inbag,
        int *oobpair, int n) {
    /* Accumulate the number of times a pair of points fall in the same node.
   prox:    n x n proximity matrix
   oobprox: should the accumulation only count OOB cases? (0=no, 1=yes)
   node:    vector of terminal node labels
   inbag:   indicator of whether a case is in-bag
   oobpair: matrix to accumulate the number of times a pair is OOB together
   n:       total number of cases
     */
    int i, j;
    for (i = 0; i < n; ++i) {
        for (j = i+1; j < n; ++j) {
            if (oobprox) {
                /* if (jin[k] == 0 && jin[n] == 0) { */
                if ((inbag[i] > 0) ^ (inbag[j] > 0)) {
                    oobpair[j*n + i] ++;
                    oobpair[i*n + j] ++;
                    if (node[i] == node[j]) {
                        prox[j*n + i] += 1.0;
                        prox[i*n + j] += 1.0;
                    }
                }
            } else {
                if (node[i] == node[j]) {
                    prox[j*n + i] += 1.0;
                    prox[i*n + j] += 1.0;
                }
            }
        }
    }
}

void permuteOOB(int m, double *x, int *in, int nsample, int mdim) {
    /* Permute the OOB part of a variable in x.
     * Argument:
     *   m: the variable to be permuted
     *   x: the data matrix (variables in rows)
     *   in: vector indicating which case is OOB
     *   nsample: number of cases in the data
     *   mdim: number of variables in the data
     */
    double *tp, tmp;
    int i, last, k, nOOB = 0;
    
    tp = (double *) calloc(nsample , sizeof(double));
    
    for (i = 0; i < nsample; ++i) {
        /* make a copy of the OOB part of the data into tp (for permuting) */
        if (in[i] == 0) {
            tp[nOOB] = x[m + i*mdim];
            nOOB++;
        }
    }
    /* Permute tp */
    last = nOOB;
    for (i = 0; i < nOOB; ++i) {
        k = (int) last * unif_rand();
        tmp = tp[last - 1];
        tp[last - 1] = tp[k];
        tp[k] = tmp;
        last--;
    }
    
    /* Copy the permuted OOB data back into x. */
    nOOB = 0;
    for (i = 0; i < nsample; ++i) {
        if (in[i] == 0) {
            x[m + i*mdim] = tp[nOOB];
            nOOB++;
        }
    }
    free(tp);
}



void simpleLinReg(int nsample, double *x, double *y, double *coef,
        double *mse, int *hasPred);
void predictRegTree(double *x, int nsample, int mdim,
        int *lDaughter, int *rDaughter, SMALL_INT *nodestatus,
        double *ypred, double *split, double *nodepred,
        int *splitVar, int treeSize, int *cat, int maxcat,
        int *nodex) ;
void regRF(double *x, double *y, int *xdim, int *sampsize,
        int *nthsize, int *nrnodes, int *nTree, int *mtry, int *imp,
        int *cat, int maxcat, int *jprint, int doProx, int oobprox,
        int biasCorr, double *yptr, double *errimp, double *impmat,
        double *impSD, double *prox, int *treeSize, SMALL_INT *nodestatus,
        int *lDaughter, int *rDaughter, double *avnode, int *mbest,
        double *upper, double *mse, const int *keepf, int *replace,
        int testdat, double *xts, int *nts, double *yts, int labelts,
        double *yTestPred, double *proxts, double *msets, double *coef,
        int *nout, int *inbag) ;

void regForest(double *x, double *ypred, int *mdim, int *n,
        int *ntree, int *lDaughter, int *rDaughter,
        SMALL_INT *nodestatus, int *nrnodes, double *xsplit,
        double *avnodes, int *mbest, int *treeSize, int *cat,
        int maxcat, int *keepPred, double *allpred, int doProx,
        double *proxMat, int *nodes, int *nodex) ;

void regTree(double *x, double *y, int mdim, int nsample, int *lDaughter,
        int *rDaughter,
        double *upper, double *avnode, SMALL_INT *nodestatus, int nrnodes,
        int *treeSize, int nthsize, int mtry, int *mbest, int *cat,
        double *tgini, int *varUsed) ;

void findBestSplit(double *x, int *jdex, double *y, int mdim, int nsample,
        int ndstart, int ndend, int *msplit, double *decsplit,
        double *ubest, int *ndendl, int *jstat, int mtry,
        double sumnode, int nodecnt, int *cat) ;





void regRF(double *x, double *y, int *xdim, int *sampsize,
        int *nthsize, int *nrnodes, int *nTree, int *mtry, int *imp,
        int *cat, int maxcat, int *jprint, int doProx, int oobprox,
        int biasCorr, double *yptr, double *errimp, double *impmat,
        double *impSD, double *prox, int *treeSize, SMALL_INT *nodestatus,
        int *lDaughter, int *rDaughter, double *avnode, int *mbest,
        double *upper, double *mse, const int *keepf, int *replace,
        int testdat, double *xts, int *nts, double *yts, int labelts,
        double *yTestPred, double *proxts, double *msets, double *coef,
        int *nout, int *inbag) {
    /*************************************************************************
     * Input:
     * mdim=number of variables in data set
     * nsample=number of cases
     *
     * nthsize=number of cases in a node below which the tree will not split,
     * setting nthsize=5 generally gives good results.
     *
     * nTree=number of trees in run.  200-500 gives pretty good results
     *
     * mtry=number of variables to pick to split on at each node.  mdim/3
     * seems to give genrally good performance, but it can be
     * altered up or down
     *
     * imp=1 turns on variable importance.  This is computed for the
     * mth variable as the percent rise in the test set mean sum-of-
     * squared errors when the mth variable is randomly permuted.
     *
     *************************************************************************/
    
    double errts = 0.0, averrb, meanY, meanYts, varY, varYts, r, xrand,
            errb = 0.0, resid=0.0, ooberr, ooberrperm, delta, *resOOB;
    
    double *yb, *xtmp, *xb, *ytr, *ytree, *tgini;
    
    int k, m, mr, n, nOOB, j, jout, idx, ntest, last, ktmp, nPerm,
            nsample, mdim, keepF, keepInbag;
    int *oobpair, varImp, localImp, *varUsed;
    
    int *in, *nind, *nodex, *nodexts;
    
    //Abhi:temp variable
    double tmp_d;
    int tmp_i;
    SMALL_INT tmp_c;
    
    //Do initialization for COKUS's Random generator
    seedMT(2*rand()+1);  //works well with odd number so why don't use that
    
    nsample = xdim[0];
    mdim = xdim[1];
    ntest = *nts;
    varImp = imp[0];
    localImp = imp[1];
    nPerm = imp[2]; //printf("nPerm %d\n",nPerm);
    keepF = keepf[0];
    keepInbag = keepf[1];
    
    if (*jprint == 0) *jprint = *nTree + 1;
    
    yb         = (double *) calloc(*sampsize, sizeof(double));
    xb         = (double *) calloc(mdim * *sampsize, sizeof(double));
    ytr        = (double *) calloc(nsample, sizeof(double));
    xtmp       = (double *) calloc(nsample, sizeof(double));
    resOOB     = (double *) calloc(nsample, sizeof(double));
    
    in        = (int *) calloc(nsample, sizeof(int));
    nodex      = (int *) calloc(nsample, sizeof(int));
    varUsed    = (int *) calloc(mdim, sizeof(int));
    nind = *replace ? NULL : (int *) calloc(nsample, sizeof(int));
    
    if (testdat) {
        ytree      = (double *) calloc(ntest, sizeof(double));
        nodexts    = (int *) calloc(ntest, sizeof(int));
    }
    oobpair = (doProx && oobprox) ?
        (int *) calloc(nsample * nsample, sizeof(int)) : NULL;
        
        /* If variable importance is requested, tgini points to the second
       "column" of errimp, otherwise it's just the same as errimp. */
        tgini = varImp ? errimp + mdim : errimp;
        
        averrb = 0.0;
        meanY = 0.0;
        varY = 0.0;
        
        zeroDouble(yptr, nsample);
        zeroInt(nout, nsample);
        for (n = 0; n < nsample; ++n) {
            varY += n * (y[n] - meanY)*(y[n] - meanY) / (n + 1);
            meanY = (n * meanY + y[n]) / (n + 1);
        }
        varY /= nsample;
        
        varYts = 0.0;
        meanYts = 0.0;
        if (testdat) {
            for (n = 0; n < ntest; ++n) {
                varYts += n * (yts[n] - meanYts)*(yts[n] - meanYts) / (n + 1);
                meanYts = (n * meanYts + yts[n]) / (n + 1);
            }
            varYts /= ntest;
        }
        
        if (doProx) {
            zeroDouble(prox, nsample * nsample);
            if (testdat) zeroDouble(proxts, ntest * (nsample + ntest));
        }
        
        if (varImp) {
            zeroDouble(errimp, mdim * 2);
            if (localImp) zeroDouble(impmat, nsample * mdim);
        } else {
            zeroDouble(errimp, mdim);
        }
        if (labelts) zeroDouble(yTestPred, ntest);
        
        /* print header for running output */
        if (*jprint <= *nTree) {
            printf("     |      Out-of-bag   ");
            if (testdat) printf("|       Test set    ");
            printf("|\n");
            printf("Tree |      MSE  %%Var(y) ");
            if (testdat) printf("|      MSE  %%Var(y) ");
            printf("|\n");
        }
        GetRNGstate();
        /*************************************
         * Start the loop over trees.
         *************************************/
        for (j = 0; j < *nTree; ++j) {
            //printf("tree num %d\n",j);fflush(stdout);
            //printf("1. maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d\n", *maxcat, *jprint, doProx, oobprox, biasCorr);
            
            idx = keepF ? j * *nrnodes : 0;
            zeroInt(in, nsample);
            zeroInt(varUsed, mdim);
            /* Draw a random sample for growing a tree. */
//		printf("1.8. maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            if (*replace) { /* sampling with replacement */
                for (n = 0; n < *sampsize; ++n) {
                    xrand = unif_rand();
                    k = xrand * nsample;
                    in[k] = 1;
                    yb[n] = y[k];
                    for(m = 0; m < mdim; ++m) {
                        xb[m + n * mdim] = x[m + k * mdim];
                    }
                }
            } else { /* sampling w/o replacement */
                for (n = 0; n < nsample; ++n) nind[n] = n;
                last = nsample - 1;
                for (n = 0; n < *sampsize; ++n) {
                    ktmp = (int) (unif_rand() * (last+1));
                    k = nind[ktmp];
                    swapInt(nind[ktmp], nind[last]);
                    last--;
                    in[k] = 1;
                    yb[n] = y[k];
                    for(m = 0; m < mdim; ++m) {
                        xb[m + n * mdim] = x[m + k * mdim];
                    }
                }
            }
            if (keepInbag) {
                for (n = 0; n < nsample; ++n) inbag[n + j * nsample] = in[n];
            }
//		printf("1.9. maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            /* grow the regression tree */
            regTree(xb, yb, mdim, *sampsize, lDaughter + idx, rDaughter + idx,
                    upper + idx, avnode + idx, nodestatus + idx, *nrnodes,
                    treeSize + j, *nthsize, *mtry, mbest + idx, cat, tgini,
                    varUsed);
            /* predict the OOB data with the current tree */
            /* ytr is the prediction on OOB data by the current tree */
            
//		printf("2. maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            predictRegTree(x, nsample, mdim, lDaughter + idx,
                    rDaughter + idx, nodestatus + idx, ytr, upper + idx,
                    avnode + idx, mbest + idx, treeSize[j], cat, maxcat,
                    nodex);
            /* yptr is the aggregated prediction by all trees grown so far */
            errb = 0.0;
            ooberr = 0.0;
            jout = 0; /* jout is the number of cases that has been OOB so far */
            nOOB = 0; /* nOOB is the number of OOB samples for this tree */
            for (n = 0; n < nsample; ++n) {
                if (in[n] == 0) {
                    nout[n]++;
                    nOOB++;
                    yptr[n] = ((nout[n]-1) * yptr[n] + ytr[n]) / nout[n];
                    resOOB[n] = ytr[n] - y[n];
                    ooberr += resOOB[n] * resOOB[n];
                }
                if (nout[n]) {
                    jout++;
                    errb += (y[n] - yptr[n]) * (y[n] - yptr[n]);
                }
            }
            errb /= jout;
            /* Do simple linear regression of y on yhat for bias correction. */
            if (biasCorr) simpleLinReg(nsample, yptr, y, coef, &errb, nout);
//printf("2.5.maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d\n", maxcat, *jprint, doProx, oobprox, biasCorr);
            
            /* predict testset data with the current tree */
            if (testdat) {
                predictRegTree(xts, ntest, mdim, lDaughter + idx,
                        rDaughter + idx, nodestatus + idx, ytree,
                        upper + idx, avnode + idx,
                        mbest + idx, treeSize[j], cat, maxcat, nodexts);
                /* ytree is the prediction for test data by the current tree */
                /* yTestPred is the average prediction by all trees grown so far */
                errts = 0.0;
                for (n = 0; n < ntest; ++n) {
                    yTestPred[n] = (j * yTestPred[n] + ytree[n]) / (j + 1);
                }
                /* compute testset MSE */
                if (labelts) {
                    for (n = 0; n < ntest; ++n) {
                        resid = biasCorr ?
                            yts[n] - (coef[0] + coef[1]*yTestPred[n]) :
                            yts[n] - yTestPred[n];
                            errts += resid * resid;
                    }
                    errts /= ntest;
                }
            }
//printf("2.6.maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d, testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            /* Print running output. */
            if ((j + 1) % *jprint == 0) {
                printf("%4d |", j + 1);
                printf(" %8.4g %8.2f ", errb, 100 * errb / varY);
                if(labelts == 1) printf("| %8.4g %8.2f ",
                        errts, 100.0 * errts / varYts);
                printf("|\n");
            }
            
//printf("2.7.maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d, testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            mse[j] = errb;
            if (labelts) msets[j] = errts;
//printf("2.701  j %d, nTree %d, errts %f errb %f \n", j, *nTree, errts,errb);
//printf("2.71.maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d, testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            /*  DO PROXIMITIES */
            if (doProx) {
                computeProximity(prox, oobprox, nodex, in, oobpair, nsample);
                /* proximity for test data */
                if (testdat) {
                    /* In the next call, in and oobpair are not used. */
                    computeProximity(proxts, 0, nodexts, in, oobpair, ntest);
                    for (n = 0; n < ntest; ++n) {
                        for (k = 0; k < nsample; ++k) {
                            if (nodexts[n] == nodex[k]) {
                                proxts[n + ntest * (k+ntest)] += 1.0;
                            }
                        }
                    }
                }
            }
//printf("2.8.maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d, testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
            /* Variable importance */
            if (varImp) {
                for (mr = 0; mr < mdim; ++mr) {
                    if (varUsed[mr]) { /* Go ahead if the variable is used */
                        /* make a copy of the m-th variable into xtmp */
                        for (n = 0; n < nsample; ++n)
                            xtmp[n] = x[mr + n * mdim];
                        ooberrperm = 0.0;
                        for (k = 0; k < nPerm; ++k) {
                            permuteOOB(mr, x, in, nsample, mdim);
                            predictRegTree(x, nsample, mdim, lDaughter + idx,
                                    rDaughter + idx, nodestatus + idx, ytr,
                                    upper + idx, avnode + idx, mbest + idx,
                                    treeSize[j], cat, maxcat, nodex);
                            for (n = 0; n < nsample; ++n) {
                                if (in[n] == 0) {
                                    r = ytr[n] - y[n];
                                    ooberrperm += r * r;
                                    if (localImp) {
                                        impmat[mr + n * mdim] +=
                                                (r*r - resOOB[n]*resOOB[n]) / nPerm;
                                    }
                                }
                            }
                        }
                        delta = (ooberrperm / nPerm - ooberr) / nOOB;
                        errimp[mr] += delta;
                        impSD[mr] += delta * delta;
                        /* copy original data back */
                        for (n = 0; n < nsample; ++n)
                            x[mr + n * mdim] = xtmp[n];
                    }
                    
                }
                
            }
//	printf("3. maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d testdat %d\n", maxcat, *jprint, doProx, oobprox, biasCorr,testdat);
            
        }
        PutRNGstate();
        /* end of tree iterations=======================================*/
        
        if (biasCorr) {  /* bias correction for predicted values */
            for (n = 0; n < nsample; ++n) {
                if (nout[n]) yptr[n] = coef[0] + coef[1] * yptr[n];
            }
            if (testdat) {
                for (n = 0; n < ntest; ++n) {
                    yTestPred[n] = coef[0] + coef[1] * yTestPred[n];
                }
            }
        }
        
        if (doProx) {
            for (n = 0; n < nsample; ++n) {
                for (k = n + 1; k < nsample; ++k) {
                    prox[nsample*k + n] /= oobprox ?
                        (oobpair[nsample*k + n] > 0 ? oobpair[nsample*k + n] : 1) :
                            *nTree;
                            prox[nsample * n + k] = prox[nsample * k + n];
                }
                prox[nsample * n + n] = 1.0;
            }
            if (testdat) {
                for (n = 0; n < ntest; ++n)
                    for (k = 0; k < ntest + nsample; ++k)
                        proxts[ntest*k + n] /= *nTree;
            }
        }
        
        if (varImp) {
            for (m = 0; m < mdim; ++m) {
                errimp[m] = errimp[m] / *nTree;
                impSD[m] = sqrt( ((impSD[m] / *nTree) -
                        (errimp[m] * errimp[m])) / *nTree );
                if (localImp) {
                    for (n = 0; n < nsample; ++n) {
                        impmat[m + n * mdim] /= nout[n];
                    }
                }
            }
        }
        for (m = 0; m < mdim; ++m) tgini[m] /= *nTree;
        
        
        //addition by abhi
        //in order to release the space stored by the variable in findBestSplit
        // call by setting
        in_findBestSplit=-99;
        findBestSplit(&tmp_d, &tmp_i, &tmp_d, tmp_i, tmp_i,
                tmp_i, tmp_i, &tmp_i, &tmp_d,
                &tmp_d, &tmp_i, &tmp_i, tmp_i,
                tmp_d, tmp_i, &tmp_i);
        
        //do the same freeing of space by calling with -99
        in_regTree=-99;
        regTree(&tmp_d, &tmp_d, tmp_i, tmp_i, &tmp_i,
                &tmp_i,
                &tmp_d, &tmp_d, &tmp_c, tmp_i,
                &tmp_i, tmp_i, tmp_i, &tmp_i, &tmp_i,
                &tmp_d, &tmp_i);
	
	
	free(yb);
        free(xb);
	free(ytr);
	free(xtmp);
	free(resOOB);
        free(in);
	free(nodex);
	free(varUsed);
    if (!(*replace)  )
        free(nind);
    
    if (testdat) {
		free(ytree);
		free(nodexts);
	}
	
	if (doProx && oobprox)
		free(oobpair) ;
}

/*----------------------------------------------------------------------*/
void regForest(double *x, double *ypred, int *mdim, int *n,
        int *ntree, int *lDaughter, int *rDaughter,
        SMALL_INT *nodestatus, int *nrnodes, double *xsplit,
        double *avnodes, int *mbest, int *treeSize, int *cat,
        int maxcat, int *keepPred, double *allpred, int doProx,
        double *proxMat, int *nodes, int *nodex) {
    int i, j, idx1, idx2, *junk;
    double *ytree;
    
    junk = NULL;
    ytree = (double *) calloc(*n, sizeof(double));
    if (*nodes) {
        zeroInt(nodex, *n * *ntree);
    } else {
        zeroInt(nodex, *n);
    }
    if (doProx) zeroDouble(proxMat, *n * *n);
    if (*keepPred) zeroDouble(allpred, *n * *ntree);
    idx1 = 0;
    idx2 = 0;
    for (i = 0; i < *ntree; ++i) {
        zeroDouble(ytree, *n);
        predictRegTree(x, *n, *mdim, lDaughter + idx1, rDaughter + idx1,
                nodestatus + idx1, ytree, xsplit + idx1,
                avnodes + idx1, mbest + idx1, treeSize[i], cat, maxcat,
                nodex + idx2);
        
        for (j = 0; j < *n; ++j) ypred[j] += ytree[j];
        if (*keepPred) {
            for (j = 0; j < *n; ++j) allpred[j + i * *n] = ytree[j];
        }
        /* if desired, do proximities for this round */
        if (doProx) computeProximity(proxMat, 0, nodex + idx2, junk,
                junk, *n);
        idx1 += *nrnodes; /* increment the offset */
        if (*nodes) idx2 += *n;
    }
    for (i = 0; i < *n; ++i) ypred[i] /= *ntree;
    if (doProx) {
        for (i = 0; i < *n; ++i) {
            for (j = i + 1; j < *n; ++j) {
                proxMat[i + j * *n] /= *ntree;
                proxMat[j + i * *n] = proxMat[i + j * *n];
            }
            proxMat[i + i * *n] = 1.0;
        }
    }
    free(ytree);
}

void simpleLinReg(int nsample, double *x, double *y, double *coef,
        double *mse, int *hasPred) {
    /* Compute simple linear regression of y on x, returning the coefficients,
   the average squared residual, and the predicted values (overwriting y). */
    int i, nout = 0;
    double sxx=0.0, sxy=0.0, xbar=0.0, ybar=0.0;
    double dx = 0.0, dy = 0.0, py=0.0;
    
    for (i = 0; i < nsample; ++i) {
        if (hasPred[i]) {
            nout++;
            xbar += x[i];
            ybar += y[i];
        }
    }
    xbar /= nout;
    ybar /= nout;
    
    for (i = 0; i < nsample; ++i) {
        if (hasPred[i]) {
            dx = x[i] - xbar;
            dy = y[i] - ybar;
            sxx += dx * dx;
            sxy += dx * dy;
        }
    }
    coef[1] = sxy / sxx;
    coef[0] = ybar - coef[1] * xbar;
    
    *mse = 0.0;
    for (i = 0; i < nsample; ++i) {
        if (hasPred[i]) {
            py = coef[0] + coef[1] * x[i];
            dy = y[i] - py;
            *mse += dy * dy;
            /* y[i] = py; */
        }
    }
    *mse /= nout;
    return;
}


void regTree(double *x, double *y, int mdim, int nsample, int *lDaughter,
        int *rDaughter,
        double *upper, double *avnode, SMALL_INT *nodestatus, int nrnodes,
        int *treeSize, int nthsize, int mtry, int *mbest, int *cat,
        double *tgini, int *varUsed) {
    int i, j, k, m, ncur;
    static int *jdex, *nodestart, *nodepop;
    int ndstart, ndend, ndendl, nodecnt, jstat, msplit;
    double d, ss, av, decsplit, ubest, sumnode;
    
    if (in_regTree==-99){
        free(nodestart);
        free(jdex);
        free(nodepop);
//	printf("giving up mem in in_regTree\n");
        return;
    }
    
    if (in_regTree==0){
        in_regTree=1;
        nodestart = (int *) calloc(nrnodes, sizeof(int));
        nodepop   = (int *) calloc(nrnodes, sizeof(int));
        jdex = (int *) calloc(nsample, sizeof(int));
    }
    
    /* initialize some arrays for the tree */
    zeroSMALLInt(nodestatus, nrnodes);
    zeroInt(nodestart, nrnodes);
    zeroInt(nodepop, nrnodes);
    zeroDouble(avnode, nrnodes);
    
    for (i = 1; i <= nsample; ++i) jdex[i-1] = i;
    
    ncur = 0;
    nodestart[0] = 0;
    nodepop[0] = nsample;
    nodestatus[0] = NODE_TOSPLIT;
    
    /* compute mean and sum of squares for Y */
    av = 0.0;
    ss = 0.0;
    for (i = 0; i < nsample; ++i) {
        d = y[jdex[i] - 1];
        ss += i * (av - d) * (av - d) / (i + 1);
        av = (i * av + d) / (i + 1);
    }
    avnode[0] = av;
    
    /* start main loop */
    for (k = 0; k < nrnodes - 2; ++k) {
        if (k > ncur || ncur >= nrnodes - 2) break;
        /* skip if the node is not to be split */
        if (nodestatus[k] != NODE_TOSPLIT) continue;
        
        /* initialize for next call to findbestsplit */
        ndstart = nodestart[k];
        ndend = ndstart + nodepop[k] - 1;
        nodecnt = nodepop[k];
        sumnode = nodecnt * avnode[k];
        jstat = 0;
        decsplit = 0.0;
        
        findBestSplit(x, jdex, y, mdim, nsample, ndstart, ndend, &msplit,
                &decsplit, &ubest, &ndendl, &jstat, mtry, sumnode,
                nodecnt, cat);
        if (jstat == 1) {
            /* Node is terminal: Mark it as such and move on to the next. */
            nodestatus[k] = NODE_TERMINAL;
            continue;
        }
        /* Found the best split. */
        mbest[k] = msplit;
        varUsed[msplit - 1] = 1;
        upper[k] = ubest;
        tgini[msplit - 1] += decsplit;
        nodestatus[k] = NODE_INTERIOR;
        
        /* leftnode no.= ncur+1, rightnode no. = ncur+2. */
        nodepop[ncur + 1] = ndendl - ndstart + 1;
        nodepop[ncur + 2] = ndend - ndendl;
        nodestart[ncur + 1] = ndstart;
        nodestart[ncur + 2] = ndendl + 1;
        
        /* compute mean and sum of squares for the left daughter node */
        av = 0.0;
        ss = 0.0;
        for (j = ndstart; j <= ndendl; ++j) {
            d = y[jdex[j]-1];
            m = j - ndstart;
            ss += m * (av - d) * (av - d) / (m + 1);
            av = (m * av + d) / (m+1);
        }
        avnode[ncur+1] = av;
        nodestatus[ncur+1] = NODE_TOSPLIT;
        if (nodepop[ncur + 1] <= nthsize) {
            nodestatus[ncur + 1] = NODE_TERMINAL;
        }
        
        /* compute mean and sum of squares for the right daughter node */
        av = 0.0;
        ss = 0.0;
        for (j = ndendl + 1; j <= ndend; ++j) {
            d = y[jdex[j]-1];
            m = j - (ndendl + 1);
            ss += m * (av - d) * (av - d) / (m + 1);
            av = (m * av + d) / (m + 1);
        }
        avnode[ncur + 2] = av;
        nodestatus[ncur + 2] = NODE_TOSPLIT;
        if (nodepop[ncur + 2] <= nthsize) {
            nodestatus[ncur + 2] = NODE_TERMINAL;
        }
        
        /* map the daughter nodes */
        lDaughter[k] = ncur + 1 + 1;
        rDaughter[k] = ncur + 2 + 1;
        /* Augment the tree by two nodes. */
        ncur += 2;
    }
    *treeSize = nrnodes;
    for (k = nrnodes - 1; k >= 0; --k) {
        if (nodestatus[k] == 0) (*treeSize)--;
        if (nodestatus[k] == NODE_TOSPLIT) {
            nodestatus[k] = NODE_TERMINAL;
        }
    }
    
}

/*--------------------------------------------------------------*/

void findBestSplit(double *x, int *jdex, double *y, int mdim, int nsample,
        int ndstart, int ndend, int *msplit, double *decsplit,
        double *ubest, int *ndendl, int *jstat, int mtry,
        double sumnode, int nodecnt, int *cat) {
    int last, ncat[32], icat[32], lc, nl, nr, npopl, npopr;
    int i, j, kv, l;
    static int *mind, *ncase;
    static double *xt, *ut, *v, *yl;
    double sumcat[32], avcat[32], tavcat[32], ubestt;
    double crit, critmax, critvar, suml, sumr, d, critParent;
    
    
    if (in_findBestSplit==-99){
      free(ncase);
      free(mind); //had to remove this so that it wont crash for when mdim=0, strangely happened for replace=0
      free(v);
      free(yl);
      free(xt);
      free(ut);
     //	printf("giving up mem in findBestSplit\n");
      return;
    }			
    
    if (in_findBestSplit==0){
    	in_findBestSplit=1;
		ut = (double *) calloc(nsample, sizeof(double));
		xt = (double *) calloc(nsample, sizeof(double));
		v  = (double *) calloc(nsample, sizeof(double));
		yl = (double *) calloc(nsample, sizeof(double));
		mind  = (int *) calloc(mdim+1, sizeof(int));   //seems that the sometimes i am asking for kv[10] and that causes problesmms
													   //so allocate 1 more. helps with not crashing in windows
		ncase = (int *) calloc(nsample, sizeof(int));
    }
    zeroDouble(ut, nsample);
    zeroDouble(xt, nsample);
    zeroDouble(v, nsample);
    zeroDouble(yl, nsample);
    zeroInt(mind, mdim);
    zeroInt(ncase, nsample);
    
    zeroDouble(avcat, 32);
    zeroDouble(tavcat, 32);
    
    /* START BIG LOOP */
    *msplit = -1;
    *decsplit = 0.0;
    critmax = 0.0;
    ubestt = 0.0;
    for (i=0; i < mdim; ++i) mind[i] = i;
    
    last = mdim - 1;
    for (i = 0; i < mtry; ++i) {
        critvar = 0.0;
        j = (int) (unif_rand() * (last+1));
        //printf("j=%d, last=%d mind[j]=%d\n", j, last, mind[j]);fflush(stdout);
        kv = mind[j];
		//if(kv>100){
		//	1;
		//	getchar();
		//}
        swapInt(mind[j], mind[last]);
        /* mind[j] = mind[last];
         * mind[last] = kv; */
        last--;
        
        lc = cat[kv];
        if (lc == 1) {
            /* numeric variable */
            for (j = ndstart; j <= ndend; ++j) {
                xt[j] = x[kv + (jdex[j] - 1) * mdim];
                yl[j] = y[jdex[j] - 1];
            }
        } else {
            /* categorical variable */
            zeroInt(ncat, 32);
            zeroDouble(sumcat, 32);
            for (j = ndstart; j <= ndend; ++j) {
                l = (int) x[kv + (jdex[j] - 1) * mdim];
                sumcat[l - 1] += y[jdex[j] - 1];
                ncat[l - 1] ++;
            }
            /* Compute means of Y by category. */
            for (j = 0; j < lc; ++j) {
                avcat[j] = ncat[j] ? sumcat[j] / ncat[j] : 0.0;
            }
            /* Make the category mean the `pseudo' X data. */
            for (j = 0; j < nsample; ++j) {
                xt[j] = avcat[(int) x[kv + (jdex[j] - 1) * mdim] - 1];
                yl[j] = y[jdex[j] - 1];
            }
        }
        /* copy the x data in this node. */
        for (j = ndstart; j <= ndend; ++j) v[j] = xt[j];
        for (j = 1; j <= nsample; ++j) ncase[j - 1] = j;
        R_qsort_I(v, ncase, ndstart + 1, ndend + 1);
        if (v[ndstart] >= v[ndend]) continue;
        /* ncase(n)=case number of v nth from bottom */
        /* Start from the right and search to the left. */
        critParent = sumnode * sumnode / nodecnt;
        suml = 0.0;
        sumr = sumnode;
        npopl = 0;
        npopr = nodecnt;
        crit = 0.0;
        /* Search through the "gaps" in the x-variable. */
        for (j = ndstart; j <= ndend - 1; ++j) {
            d = yl[ncase[j] - 1];
            suml += d;
            sumr -= d;
            npopl++;
            npopr--;
            if (v[j] < v[j+1]) {
                crit = (suml * suml / npopl) + (sumr * sumr / npopr) -
                        critParent;
                if (crit > critvar) {
                    ubestt = (v[j] + v[j+1]) / 2.0;
                    critvar = crit;
                }
            }
        }
        if (critvar > critmax) {
            *ubest = ubestt;
            *msplit = kv + 1;
            critmax = critvar;
            for (j = ndstart; j <= ndend; ++j) {
                ut[j] = xt[j];
            }
            if (cat[kv] > 1) {
                for (j = 0; j < cat[kv]; ++j) tavcat[j] = avcat[j];
            }
        }
    }
    *decsplit = critmax;
    
    /* If best split can not be found, set to terminal node and return. */
    if (*msplit != -1) {
        nl = ndstart;
        for (j = ndstart; j <= ndend; ++j) {
            if (ut[j] <= *ubest) {
                nl++;
                ncase[nl-1] = jdex[j];
            }
        }
        *ndendl = imax2(nl - 1, ndstart);
        nr = *ndendl + 1;
        for (j = ndstart; j <= ndend; ++j) {
            if (ut[j] > *ubest) {
                if (nr >= nsample) break;
                nr++;
                ncase[nr - 1] = jdex[j];
            }
        }
        if (*ndendl >= ndend) *ndendl = ndend - 1;
        for (j = ndstart; j <= ndend; ++j) jdex[j] = ncase[j];
        
        lc = cat[*msplit - 1];
        if (lc > 1) {
            for (j = 0; j < lc; ++j) {
                icat[j] = (tavcat[j] < *ubest) ? 1 : 0;
            }
            *ubest = pack(lc, icat);
        }
    } else *jstat = 1;
    
}
/*====================================================================*/
void predictRegTree(double *x, int nsample, int mdim,
        int *lDaughter, int *rDaughter, SMALL_INT *nodestatus,
        double *ypred, double *split, double *nodepred,
        int *splitVar, int treeSize, int *cat, int maxcat,
        int *nodex) {
    int i, j, k, m, *cbestsplit;
    unsigned int npack;
    
    /* decode the categorical splits */
    if (maxcat > 1) {
        cbestsplit = (int *) calloc(maxcat * treeSize, sizeof(int));
        zeroInt(cbestsplit, maxcat * treeSize);
        for (i = 0; i < treeSize; ++i) {
            if (nodestatus[i] != NODE_TERMINAL && cat[splitVar[i] - 1] > 1) {
                npack = (unsigned int) split[i];
                /* unpack `npack' into bits */
                for (j = 0; npack; npack >>= 1, ++j) {
                    cbestsplit[j + i*maxcat] = npack & 1;
                }
            }
        }
    }
    
    for (i = 0; i < nsample; ++i) {
        k = 0;
        while (nodestatus[k] != NODE_TERMINAL) { /* go down the tree */
            m = splitVar[k] - 1;
            if (cat[m] == 1) {
                k = (x[m + i*mdim] <= split[k]) ?
                    lDaughter[k] - 1 : rDaughter[k] - 1;
            } else {
                /* Split by a categorical predictor */
                k = cbestsplit[(int) x[m + i * mdim] - 1 + k * maxcat] ?
                    lDaughter[k] - 1 : rDaughter[k] - 1;
            }
        }
        /* terminal node: assign prediction and move on to next */
        ypred[i] = nodepred[k];
        nodex[i] = k + 1;
    }
    if (maxcat > 1) free(cbestsplit);
}



void print_regRF_params( int *xdim, int *sampsize,
        int *nthsize, int *nrnodes, int *nTree, int *mtry, int *imp,
        int *cat, int maxcat, int *jprint, int doProx, int oobprox,
        int biasCorr, double *yptr, double *errimp, double *impmat,
        double *impSD, double *prox, int *treeSize, SMALL_INT *nodestatus,
        int *lDaughter, int *rDaughter, double *avnode, int *mbest,
        double *upper, double *mse, int *keepf, int *replace,
        int testdat, double *xts, int *nts, double *yts, int labelts,
        double *yTestPred, double *proxts, double *msets, double *coef,
        int *nout, int *inbag)	{
    printf("n_size %d p_size %d\n", xdim[0], xdim[1]);
    printf("sampsize %d, nodesize %d nrnodes %d\n", *sampsize, *nthsize, *nrnodes);
    printf("ntree %d, mtry/nvar %d, impor %d, localimp %d, nPerm %d\n", *nTree, *mtry, imp[0], imp[1], imp[2]);
    printf("maxcat %d, jprint %d, doProx %d, oobProx %d, biasCorr %d\n", maxcat, *jprint, doProx, oobprox, biasCorr);
    printf("prox %f, keep.forest %d, keep.inbag %d\n", *prox, keepf[0], keepf[1]);
    printf("replace %d, labelts %d, proxts %f\n", *replace, labelts, *proxts);
}
