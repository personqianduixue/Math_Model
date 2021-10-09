/**************************************************************
 * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 *
 * File: contains all the other supporting code for a standalone C or mex for
 *       Classification RF. 
 * Copied all the code from the randomForest 4.5-28 or was it -29?
 * added externs "C"'s  and the F77_* macros
 *
 *************************************************************/

/*******************************************************************
   Copyright (C) 2001-7 Leo Breiman, Adele Cutler and Merck & Co., Inc.

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
*******************************************************************/
#include "rf.h"
#include "memory.h"
#include "stdlib.h"
#include "math.h"

#ifdef MATLAB
#define Rprintf  mexPrintf
#include "mex.h"
#endif

#ifndef MATLAB
#define Rprintf printf
#include "stdio.h"
#endif

typedef unsigned long uint32;
extern void seedMT(uint32 seed);
extern uint32 reloadMT(void);
extern uint32 randomMT(void);
extern double unif_rand();
extern void R_qsort_I(double *v, int *I, int i, int j);

extern "C"{
    #ifdef WIN64
	void _catmax_(double *parentDen, double *tclasscat,
                      double *tclasspop, int *nclass, int *lcat,
                      int *ncatsp, double *critmax, int *nhit,
                      int *maxcat, int *ncmax, int *ncsplit);
    #endif
    
    #ifndef WIN64
	void catmax_(double *parentDen, double *tclasscat,
                      double *tclasspop, int *nclass, int *lcat,
                      int *ncatsp, double *critmax, int *nhit,
                      int *maxcat, int *ncmax, int *ncsplit);
    #endif                
}
extern "C"{
    #ifdef WIN64
	void _catmaxb_(double *totalWt, double *tclasscat, double *classCount,
                       int *nclass, int *nCat, int *nbest, double *critmax,
                       int *nhit, double *catCount) ;
    #endif
            
    #ifndef WIN64
	void catmaxb_(double *totalWt, double *tclasscat, double *classCount,
                       int *nclass, int *nCat, int *nbest, double *critmax,
                       int *nhit, double *catCount) ;
    #endif
}

#ifdef WIN64
void F77_NAME(_catmax)
#endif

#ifndef WIN64
void F77_NAME(catmax)
#endif
(double *parentDen, double *tclasscat,
                      double *tclasspop, int *nclass, int *lcat,
                      int *ncatsp, double *critmax, int *nhit,
                      int *maxcat, int *ncmax, int *ncsplit) {
/* This finds the best split of a categorical variable with lcat
   categories and nclass classes, where tclasscat(j, k) is the number
   of cases in class j with category value k. The method uses an
   exhaustive search over all partitions of the category values if the
   number of categories is 10 or fewer.  Otherwise ncsplit randomly
   selected splits are tested and best used. */
    int j, k, n, icat[32], nsplit;
    double leftNum, leftDen, rightNum, decGini, *leftCatClassCount;

    leftCatClassCount = (double *) calloc(*nclass, sizeof(double));
    *nhit = 0;
    nsplit = *lcat > *ncmax ?
        *ncsplit : (int) pow(2.0, (double) *lcat - 1) - 1;

    for (n = 0; n < nsplit; ++n) {
        zeroInt(icat, 32);
        if (*lcat > *ncmax) {
            /* Generate random split.
               TODO: consider changing to generating random bits with more
               efficient algorithm */
            for (j = 0; j < *lcat; ++j) icat[j] = unif_rand() > 0.5 ? 1 : 0;
        } else {
            unpack((unsigned int) n + 1, icat);
        }
        for (j = 0; j < *nclass; ++j) {
            leftCatClassCount[j] = 0;
            for (k = 0; k < *lcat; ++k) {
                if (icat[k]) {
                    leftCatClassCount[j] += tclasscat[j + k * *nclass];
                }
            }
        }
        leftNum = 0.0;
        leftDen = 0.0;
        for (j = 0; j < *nclass; ++j) {
            leftNum += leftCatClassCount[j] * leftCatClassCount[j];
            leftDen += leftCatClassCount[j];
        }
        /* If either node is empty, try another split. */
        if (leftDen <= 1.0e-8 || *parentDen - leftDen <= 1.0e-5) continue;
        rightNum = 0.0;
        for (j = 0; j < *nclass; ++j) {
            leftCatClassCount[j] = tclasspop[j] - leftCatClassCount[j];
            rightNum += leftCatClassCount[j] * leftCatClassCount[j];
        }
        decGini = (leftNum / leftDen) + (rightNum / (*parentDen - leftDen));
        if (decGini > *critmax) {
            *critmax = decGini;
            *nhit = 1;
            *ncatsp = *lcat > *ncmax ? pack((unsigned int) *lcat, icat) : n + 1;
        }
    }
    free(leftCatClassCount);
}



/* Find best split of with categorical variable when there are two classes */
#ifdef WIN64
void F77_NAME(_catmaxb)
#endif
#ifndef WIN64
void F77_NAME(catmaxb)
#endif
(double *totalWt, double *tclasscat, double *classCount,
                       int *nclass, int *nCat, int *nbest, double *critmax,
                       int *nhit, double *catCount) {

    double catProportion[32], cp[32], cm[32];
    int kcat[32];
    int i, j;
    double bestsplit=0.0, rightDen, leftDen, leftNum, rightNum, crit;

    *nhit = 0;
    for (i = 0; i < *nCat; ++i) {
        catProportion[i] = catCount[i] ?
            tclasscat[i * *nclass] / catCount[i] : 0.0;
        kcat[i] = i + 1;
    }
    R_qsort_I(catProportion, kcat, 1, *nCat);
    for (i = 0; i < *nclass; ++i) {
        cp[i] = 0;
        cm[i] = classCount[i];
    }
    rightDen = *totalWt;
    leftDen = 0.0;
    for (i = 0; i < *nCat - 1; ++i) {
        leftDen += catCount[kcat[i]-1];
        rightDen -= catCount[kcat[i]-1];
        leftNum = 0.0;
        rightNum = 0.0;
        for (j = 0; j < *nclass; ++j) {
            cp[j] += tclasscat[j + (kcat[i]-1) * *nclass];
            cm[j] -= tclasscat[j + (kcat[i]-1) * *nclass];
            leftNum += cp[j] * cp[j];
            rightNum += cm[j] * cm[j];
        }
        if (catProportion[i] < catProportion[i + 1]) {
            /* If neither node is empty, check the split. */
            if (rightDen > 1.0e-5 && leftDen > 1.0e-5) {
                crit = (leftNum / leftDen) + (rightNum / rightDen);
                if (crit > *critmax) {
                    *critmax = crit;
                    bestsplit = .5 * (catProportion[i] + catProportion[i + 1]);
                    *nhit = 1;
                }
            }
        }
    }
    if (*nhit == 1) {
        zeroInt(kcat, *nCat);
        for (i = 0; i < *nCat; ++i) {
            catProportion[i] = catCount[i] ?
                tclasscat[i * *nclass] / catCount[i] : 0.0;
            kcat[i] = catProportion[i] < bestsplit ? 1 : 0;
        }
        *nbest = pack(*nCat, kcat);
    }
}



void predictClassTree(double *x, int n, int mdim, int *treemap,
		      int *nodestatus, double *xbestsplit,
		      int *bestvar, int *nodeclass,
		      int treeSize, int *cat, int nclass,
		      int *jts, int *nodex, int maxcat) {
    int m, i, j, k, *cbestsplit;
	unsigned int npack;

    //Rprintf("maxcat %d\n",maxcat);
    /* decode the categorical splits */
    if (maxcat > 1) {
        cbestsplit = (int *) calloc(maxcat * treeSize, sizeof(int));
        zeroInt(cbestsplit, maxcat * treeSize);
        for (i = 0; i < treeSize; ++i) {
            if (nodestatus[i] != NODE_TERMINAL) {
                if (cat[bestvar[i] - 1] > 1) {
                    npack = (unsigned int) xbestsplit[i];
                    /* unpack `npack' into bits */
                    for (j = 0; npack; npack >>= 1, ++j) {
                        cbestsplit[j + i*maxcat] = npack & 01;
                    }
                }
            }
        }
    }
    for (i = 0; i < n; ++i) {
        k = 0;
        while (nodestatus[k] != NODE_TERMINAL) {
            m = bestvar[k] - 1;
            if (cat[m] == 1) {
                /* Split by a numerical predictor */
                k = (x[m + i * mdim] <= xbestsplit[k]) ?
                    treemap[k * 2] - 1 : treemap[1 + k * 2] - 1;
            } else {
                /* Split by a categorical predictor */
                k = cbestsplit[(int) x[m + i * mdim] - 1 + k * maxcat] ?
                    treemap[k * 2] - 1 : treemap[1 + k * 2] - 1;
            }
        }
        /* Terminal node: assign class label */
        jts[i] = nodeclass[k];
        nodex[i] = k + 1;
    }
    if (maxcat > 1) free(cbestsplit);
}
