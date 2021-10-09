/********************************************************************
 * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 * 
 * file info: does prediction for regression RF
 * Inputs: 
 *   x = data;
 *   lDaughter, rDaughter, nodestatus, nrnodes, xsplit, avnodes, mbest, treeSize
 *   and ntree generated from or set in mex for training 	
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

void regForest(double *x, double *ypred, int *mdim, int *n,
               int *ntree, int *lDaughter, int *rDaughter,
               SMALL_INT *nodestatus, int *nrnodes, double *xsplit,
               double *avnodes, int *mbest, int *treeSize, int *cat,
               int maxcat, int *keepPred, double *allpred, int doProx,
               double *proxMat, int *nodes, int *nodex) ;
#ifdef MATLAB
void mexFunction( int nlhs, mxArray *plhs[],
        int nrhs, const mxArray*prhs[] )
        
{
	int i;
	if (nrhs!=10)
		mexErrMsgIdAndTxt("mex_regressionRF_predict",
                "I am stupid, I need 9 parameters");
	
	int p_size = mxGetM(prhs[0]);
	int n_size = mxGetN(prhs[0]);
  
//	printf("n %d, p %d\n",n_size, p_size);
	
	double *x = (double*)mxGetData(prhs[0]);
	int *lDaughter=(int*)mxGetData(prhs[1]);
	int *rDaughter=(int*)mxGetData(prhs[2]);
	SMALL_INT *nodestatus=(SMALL_INT*)mxGetData(prhs[3]);
	int nrnodes=mxGetScalar(prhs[4]);
	double* xsplit=(double*)mxGetData(prhs[5]);
	double* avnodes=(double*)mxGetData(prhs[6]);
	int* mbest = (int*)mxGetData(prhs[7]);
	int* treeSize = (int*)mxGetData(prhs[8]);
	int ntree=mxGetScalar(prhs[9]);
	
	plhs[0]=mxCreateNumericMatrix(n_size,1,mxDOUBLE_CLASS,0);
	double* ypred = (double*)mxGetData(plhs[0]);
	
	int mdim = p_size;
	int *cat; cat = (int*) calloc(p_size, sizeof(int)); for ( i=0;i<p_size;i++) cat[i] = 1;
	int maxcat =1;
	int keepPred=0;
	double allPred=0;
	int doProx=0;
	double proxMat=0;
	int nodes=0;
	int *nodex; nodex=(int*)calloc(n_size,sizeof(int));
	
    if (DEBUG_ON){
        printf("predict: val's of first example: ");
        for(i=0;i<p_size;i++)
            printf("%f,", x[i]);
        printf("\n");
    }
    
    regForest(x, ypred, &mdim, &n_size,
               &ntree, lDaughter, rDaughter,
               nodestatus, &nrnodes, xsplit,
               avnodes, mbest, treeSize, cat,
               maxcat, &keepPred, &allPred, doProx,
               &proxMat, &nodes, nodex);
    
    //free the allocations
    free(cat);
    free(nodex);
    return;
}
#endif
