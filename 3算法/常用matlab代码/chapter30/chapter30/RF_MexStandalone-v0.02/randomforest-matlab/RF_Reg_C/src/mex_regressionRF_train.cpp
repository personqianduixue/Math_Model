/********************************************************************
 * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 *
 * file info: does training for regression RF
 * Inputs: 
 *   x = data; y = target values;
 *   ntree = (optional) number of trees
 * Outputs: 
 *   ypred = prediction for the data
 *   <no other output in this version>
********************************************************************/

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

#ifdef MATLAB
#include "mex.h"
#endif
#include "math.h"
#include "reg_RF.h"

#define DEBUG_ON 0

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


#ifdef MATLAB
void mexFunction( int nlhs, mxArray *plhs[],
        int nrhs, const mxArray*prhs[] )
        
{
    //handle output
    
    int i;
    int p_size = mxGetM(prhs[0]);
    int n_size = mxGetN(prhs[0]);
    double *x = mxGetPr(prhs[0]);
    double *y = mxGetPr(prhs[1]);
    int dimx[2];
    dimx[0]=n_size;
    dimx[1]=p_size;
    if (DEBUG_ON) printf("\n\n\n n %d, p %d\n", dimx[0], dimx[1]);
    
    int sampsize=(int)mxGetScalar(prhs[4]);
    if (DEBUG_ON) printf("sampsize %d\n", sampsize);
    int nodesize=(int)mxGetScalar(prhs[5]);
    if (DEBUG_ON) printf("nodesize %d\n", nodesize);
    
    plhs[3] = mxCreateDoubleScalar(2 * (int)(floor((float)(sampsize / (1>(nodesize - 4)?1:(nodesize - 4))) ))+ 1);
    int nrnodes = 2 * (int)((float)floor((float)(sampsize / (1>(nodesize - 4)?1:(nodesize - 4)))))+ 1;
    
    if (DEBUG_ON) printf("nrnodes %d\n", nrnodes);
    int ntree;
    int nvar;
 
    //correctness handled in .m file
    ntree=(int)mxGetScalar(prhs[2]);
    nvar=(int)mxGetScalar(prhs[3]);
    
    
    if (DEBUG_ON) mexPrintf("\nntree %d, mtry=%d\n",ntree,nvar);
    
    if (ntree<=0)
        mexErrMsgIdAndTxt("mex_regressionRF_train",
                "Cannot fathom creating 0 trees :), put the right option");
    
    //printf("ntree %d\n", ntree);
    //if (DEBUG_ON)
    //printf("nvar %d\n", nvar);
    int *imp = (int*)mxGetData(prhs[6]);
    
    //int cat[p_size];
    int *cat = (int*) mxGetData(prhs[7]);
            
    if (DEBUG_ON) printf("cat %d\n", p_size);
    //for ( i=0;i<p_size;i++) cat[i] = 1;
    
    
    int maxcat=*((int*)mxGetData(prhs[8]));
    if (DEBUG_ON) printf("maxcat %d\n", maxcat);
    int jprint=*((int*)mxGetData(prhs[9]));
    if (DEBUG_ON) printf("dotrace %d\n", maxcat);
    int doProx=*((int*)mxGetData(prhs[10]));
    if (DEBUG_ON) printf("doprox %d\n", doProx);
    int oobprox = *((int*)mxGetData(prhs[11]));
    if (DEBUG_ON) printf("oobProx %d\n", oobprox);
    int biasCorr=*((int*)mxGetData(prhs[12]));
    if (DEBUG_ON) printf("biascorr %d\n", biasCorr);
    
    //double y_pred_trn[n_size];
    plhs[8] = mxCreateNumericMatrix(n_size, 1, mxDOUBLE_CLASS, 0);
    double *y_pred_trn = mxGetPr(plhs[8]);// y_pred_trn = (double*) calloc(n_size, sizeof(double));
    if (DEBUG_ON) printf("ypredsize %d\n", n_size);
    
    double *impout;
    if (imp[0]==1){
        //double impout[p_size*2];
        plhs[10] = mxCreateNumericMatrix(p_size, 2, mxDOUBLE_CLASS, 0);
        impout = mxGetPr(plhs[10]); //(double*) calloc(p_size*2, sizeof(double));
        if (DEBUG_ON) printf("impout %d\n", p_size*2);
    }else{
        //double impout[p_size];
        plhs[10] = mxCreateNumericMatrix(p_size, 1, mxDOUBLE_CLASS, 0);
        impout = mxGetPr(plhs[10]); //(double*) calloc(p_size, sizeof(double));
        if (DEBUG_ON) printf("impout %d\n", p_size);
    }
    
    double *impmat;
    if(imp[1]==1){
        //double impmat[p_size*n_size];
        plhs[11] = mxCreateNumericMatrix(p_size, n_size, mxDOUBLE_CLASS, 0);
        impmat = mxGetPr(plhs[11]); //(double*) calloc(p_size*n_size, sizeof(double));
        if (DEBUG_ON) printf("impmat %d\n", p_size*n_size);
    }else{
        //double impmat=1;
        plhs[11] = mxCreateNumericMatrix(1, 1, mxDOUBLE_CLASS, 0);
        impmat = mxGetPr(plhs[11]); //(double*) calloc(1, sizeof(double));
        if (DEBUG_ON) printf("impmat %d\n", 1);
        impmat[0]=0;
    }
    
    double *impSD;
    if(imp[0]==1){
        //double impSD[p_size];
        plhs[12] = mxCreateNumericMatrix(p_size, 1, mxDOUBLE_CLASS, 0);
        impSD = mxGetPr(plhs[12]); //(double*)calloc(p_size, sizeof(double));
        if (DEBUG_ON) printf("impSD %d\n", p_size);
    }else{
        //double impSD=1;
        plhs[12] = mxCreateNumericMatrix(1, 1, mxDOUBLE_CLASS, 0);
        impSD = mxGetPr(plhs[12]); //(double*)calloc(1, sizeof(double));
        if (DEBUG_ON) printf("impSD %d\n", 1);
        impSD[0]=0;
    }
    
    int keepf[2];
    keepf[0]=1;
    keepf[1]=(int) mxGetScalar(prhs[13]);
    
    int nt=ntree; //always keep the tree so keepf[0]=1 and this is always ntree
    
    double *prox;
    if (doProx){
        plhs[13] = mxCreateNumericMatrix(n_size,n_size,mxDOUBLE_CLASS,0);
        prox = mxGetPr(plhs[13]);
    }else{
        plhs[13] = mxCreateNumericMatrix(1,1,mxDOUBLE_CLASS,0);
        prox = mxGetPr(plhs[13]);
    }
    	
    
    //int ndtree[ntree];
    //int *ndtree; ndtree = (int*)calloc(ntree, sizeof(int));
    plhs[7] = mxCreateNumericMatrix(ntree, 1, mxINT32_CLASS, 0);
    int *ndtree = (int*)mxGetData(plhs[7]);
    if (DEBUG_ON) printf("ntree %d\n", ntree);
    
    //int nodestatus[nrnodes * nt];
    //int *nodestatus; nodestatus = (int*)calloc(nrnodes*nt, sizeof(int));
    plhs[2] = mxCreateNumericMatrix(nrnodes, nt, SMALL_INT_CLASS, 0);
    SMALL_INT* nodestatus=(SMALL_INT*)mxGetData(plhs[2]);
    if (DEBUG_ON) printf("nodestatus %d\n", nrnodes*nt);
    
    //int lDaughter[nrnodes * nt];
    //int *lDaughter; lDaughter = (int*)calloc(nrnodes*nt, sizeof(int));
    plhs[0] = mxCreateNumericMatrix(nrnodes, nt, mxINT32_CLASS, 0);
    int *lDaughter = (int*)mxGetData(plhs[0]);
    if (DEBUG_ON) printf("lDau %d\n", nrnodes*nt);
    
    //int rDaughter[nrnodes * nt];
    //int *rDaughter; rDaughter = (int*)calloc(nrnodes*nt, sizeof(int));
    plhs[1] = mxCreateNumericMatrix(nrnodes, nt, mxINT32_CLASS, 0);
    int *rDaughter = (int*)mxGetData(plhs[1]);
    if (DEBUG_ON) printf("rDau %d\n", nrnodes*nt);
    
    //double avnode[nrnodes * nt];
    //double *avnode; avnode = (double*) calloc(nrnodes*nt, sizeof(double));
    plhs[5] = mxCreateNumericMatrix(nrnodes, nt, mxDOUBLE_CLASS, 0);
    double *avnode=(double*)mxGetData(plhs[5]);
    if (DEBUG_ON) printf("avnode %d\n", nrnodes*nt);
    
    //int mbest[nrnodes * nt];
    //int* mbest; mbest=(int*)calloc(nrnodes*nt, sizeof(int));
    plhs[6] = mxCreateNumericMatrix(nrnodes, nt, mxINT32_CLASS, 0);
    int*mbest = (int*)mxGetData(plhs[6]);
    if (DEBUG_ON) printf("mbest %d\n", nrnodes*nt);
    
    //double upper[nrnodes * nt];
    //double *upper; upper = (double*) calloc(nrnodes*nt, sizeof(double));
    plhs[4] = mxCreateNumericMatrix(nrnodes, nt, mxDOUBLE_CLASS, 0);
    double *upper=(double*)mxGetData(plhs[4]);
    if (DEBUG_ON) printf("upper %d\n", nrnodes*nt);
    
    plhs[9] = mxCreateNumericMatrix(ntree,1,mxDOUBLE_CLASS,0);
    double *mse = mxGetPr(plhs[9]);//(double*)calloc(ntree, sizeof(double));
    if (DEBUG_ON) printf("mse %f\n", mse);
    
    int replace=(int)mxGetScalar(prhs[14]);
    if (DEBUG_ON) printf("replace %d\n", replace);
    
    int testdat=0;
    //try with 1 examples for training as testing just to check for correctness. this can be removed without implications later on
    double *xts=x;
    int nts = 1;
    double *yts=y;
    int labelts=1;
    
    //double yTestPred[nts];
    double *yTestPred; yTestPred = (double*)calloc(nts, sizeof(double));
    double proxts[]={1};
    
    double *msets;
    if (labelts==1){
        msets=(double*)calloc(ntree, sizeof(double));
    }else{
        msets=(double*)calloc(ntree, sizeof(double));
        msets[0]=1;
    }
    
    plhs[14] = mxCreateNumericMatrix(2,1,mxDOUBLE_CLASS,0);
    double *coef = mxGetPr(plhs[14]);
    
    
    //int nout[n_size];
    plhs[15] = mxCreateNumericMatrix(n_size,1,mxINT32_CLASS,0);
    int* nout = (int*)mxGetData(plhs[15]); //(int*)calloc(n_size, sizeof(int));
    
    int* inbag;
    if (keepf[1]==1){
        plhs[16] = mxCreateNumericMatrix(n_size,ntree,mxINT32_CLASS,0);
        inbag=(int*)mxGetData(plhs[16]);//calloc(n_size*ntree, sizeof(int));
    }else{
        plhs[16] = mxCreateNumericMatrix(1,1,mxINT32_CLASS,0);
        inbag=(int*)mxGetData(plhs[16]);//(int*)calloc(1, sizeof(int));
        inbag[0]=1;
    }
    
    /* print_regRF_params( dimx, &sampsize,
     * &nodesize, &nrnodes, &ntree, &nvar,
     * imp, cat, maxcat, &jprint,
     * doProx, oobprox,biasCorr, y_pred_trn,
     * impout, impmat,impSD, prox,
     * ndtree, nodestatus, lDaughter, rDaughter,
     * avnode, mbest,upper, mse,
     * keepf, &replace, testdat, xts,
     * &nts, yts, labelts, yTestPred,
     * proxts, msets, coef,nout,
     * inbag) ;*/
    
    if (DEBUG_ON){
        printf("training: val's of first example: ");
        for(i=0;i<p_size;i++)
            printf("%f,", x[i]);
        printf("\n");
    }
    
    
    regRF(x, y, dimx, &sampsize,
            &nodesize, &nrnodes, &ntree, &nvar,
            imp, cat, maxcat, &jprint,
            doProx, oobprox, biasCorr, y_pred_trn,
            impout, impmat, impSD, prox,
            ndtree, nodestatus, lDaughter, rDaughter,
            avnode, mbest, upper, mse,
            keepf, &replace, testdat, xts,
            &nts, yts, labelts, yTestPred,
            proxts, msets, coef, nout,
            inbag) ;
    /*print_regRF_params( dimx, &sampsize,
     * &nodesize, &nrnodes, &ntree, &nvar,
     * imp, cat, maxcat, &jprint,
     * doProx, oobprox,biasCorr, y_pred_trn,
     * impout, impmat,impSD, prox,
     * ndtree, nodestatus, lDaughter, rDaughter,
     * avnode, mbest,upper, mse,
     * keepf, &replace, testdat, xts,
     * &nts, yts, labelts, yTestPred,
     * proxts, msets, coef,nout,
     * inbag) ;*/
    
    /*    for (i=0;i<nts;i++)
   {
       printf("(%f,%f) ",y[i],yTestPred[i]);
   }*/
    
    
    //printf("Mean of sq. residuals \t%f\n",mse[ntree-1]);
    //printf("\% var Explained  \t%f\n",mse[ntree-1]);
    
    //let the variables go free, dont because they will be used in the model
    //free(cat);
    //free(y_pred_trn);
    //free(impout);
    //free(impmat);
    //free(impSD);
    
    // the following commented out variables are needed for predicition.
    //free(ndtree);
    //free(nodestatus);
    //free(lDaughter);
    //free(rDaughter);
    //free(avnode);
    //free(mbest);
    //free(upper);
    
    //free(mse);
    //free(nout);
    //free(inbag);
    
    
    //free(yTestPred);
    //free(msets);
    
    return;
}
#endif
