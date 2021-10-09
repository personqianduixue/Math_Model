/********************************************************************
 * Standalone interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 * 
 * What this barely has: link to Random forest code, setting parameters for
 * number of tree, nvar/mtry. No support for almost everything else.
 *
 * Uses the pima indian diabetes dataset, creating the RF models and
 * testing on the dataset. This is just a simple code to show the interface
 * with the code from Andy Liaw et al. Modify as needed for custom datasets
 *
 * In this default form it will output the predictions out.
 * use DEBUG_ON to control verbosity
 *
 * to compile on linux: use the Makefile command 'make diabetes'
 *
 * to compile on windows: use either cygwin or VC++ (<CC> represents the compiler)
 *  to compile these 3 files "cokus.cpp reg_RF.cpp diabetes_C_wrapper.cpp"
 *
 * Errata: the file reading part will be needed to tweaked per requirement
 * 
 * Generating the ascii files:
 *  the data files can be generated from matlab as
 *  save('filename.mat','variable','-ascii')
 *******************************************************************/

#include "stdio.h"
#include "string.h"
#include "memory.h"
#include "math.h"
#include "stdlib.h"
#include "reg_RF.h"


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

//pima indian diabetes dataset used here in this example has 442 examples and 
//20 features or dimensions. We are reading the data matrix into X (442x20 size) matrix 
//and the target values into Y (442 size) vector

// first the models are trained in regRF and then tested in regForest

//if you want to print debug messages set the below to 1.

#define DEBUG_ON 0

int main(){
    char X_filename[100], Y_filename[100];
    FILE *fp_X, *fp_Y;
    int cols=10,rows=442,i,j;
    int p_size=cols,n_size=rows;
    char dum_str[100];
    
    double X[rows*cols], Y[rows];
    int dimx[2];
    dimx[0]=n_size;
    dimx[1]=p_size;

    /**************READ DATA***********************/	
    strcpy(X_filename,"data//X_diabetes.txt");
    strcpy(Y_filename,"data//Y_diabetes.txt");
    
    
    fp_X = fopen(X_filename,"r");
    fp_Y = fopen(Y_filename,"r");
    
    if (fp_X !=NULL)
    {
      if (DEBUG_ON) printf("file opened: %s\n",X_filename);
    }else{
      printf("cannot find files for data\n");exit(0);
    }    
    
    if (fp_Y !=NULL)
    {
      if (DEBUG_ON) printf("file opened: %s\n",Y_filename);
    }else{
      printf("cannot find files for data\n");exit(0);
    }
    fflush(stdout);
    
    for(i=0;i<rows;i++)
      for(j=0;j<cols;j++){
         fscanf(fp_X,"%s ",dum_str);
         X[i*cols+j] = atof(dum_str);
         if (DEBUG_ON)
             if(i*cols+j<300)
                 printf("%s (%f)", dum_str,X[i*cols+j]);
         //fflush(stdout);
      }
         
    for(i=0;i<rows;i++){
       fscanf(fp_Y,"%s ",dum_str);
       Y[i] = atof(dum_str);
       if(DEBUG_ON)
         if(i<300)
           printf("%f,",Y[i]);
    }
    /*******************DONE WITH READING DATA*******************/
    
    
    
    int sampsize;
    sampsize=n_size;
    if (DEBUG_ON) printf("sampsize %d\n", sampsize);
    int nodesize=5;
    if (DEBUG_ON) printf("nodesize %d\n", nodesize);
    int nsum = sampsize;
    if (DEBUG_ON) printf("nsum %d\n", nsum);
    
    int nrnodes = 2 * (int)((float)floor((float)(sampsize / (1>(nodesize - 4)?1:(nodesize - 4)))))+ 1;
    
    if (DEBUG_ON) printf("nrnodes %d\n", nrnodes);
    int ntree=500;
    
    //mtry = nvar
    int nvar=(floor((float)(p_size/3))>1)?floor((float)(p_size/3)):1;
    int imp[] = {0, 0, 1};
    
    int *cat; cat = (int*) calloc(p_size, sizeof(int));
    if (DEBUG_ON) printf("cat %d\n", p_size);
    for ( i=0;i<p_size;i++) cat[i] = 1;
    
    
    int maxcat=1;
    if (DEBUG_ON) printf("maxcat %d\n", maxcat);
    int jprint;
    if (DEBUG_ON)
        jprint=1;
    else
        jprint=0;
    if (DEBUG_ON) printf("dotrace %d\n", maxcat);
    int doProx=0;
    if (DEBUG_ON) printf("doprox %d\n", doProx);
    int oobprox = doProx;
    if (DEBUG_ON) printf("oobProx %d\n", oobprox);
    int biasCorr=0;
    if (DEBUG_ON) printf("biascorr %d\n", biasCorr);
    
    //double y_pred_trn[n_size];
    double *y_pred_trn; y_pred_trn = (double*) calloc(n_size, sizeof(double));
    if (DEBUG_ON) printf("ypredsize %d\n", n_size);
    
    double *impout;
    if (imp[0]==1){
        //double impout[p_size*2];
        impout = (double*) calloc(p_size*2, sizeof(double));
        if (DEBUG_ON) printf("impout %d\n", p_size*2);
    }else{
        //double impout[p_size];
        impout = (double*) calloc(p_size, sizeof(double));
        if (DEBUG_ON) printf("impout %d\n", p_size);
    }
    
    double *impmat;
    if(imp[1]==1){
        //double impmat[p_size*n_size];
        impmat = (double*) calloc(p_size*n_size, sizeof(double));
        if (DEBUG_ON) printf("impmat %d\n", p_size*n_size);
    }else{
        //double impmat=1;
        impmat = (double*) calloc(1, sizeof(double));
        if (DEBUG_ON) printf("impmat %d\n", 1);
        impmat[0]=0;
    }
    
    double *impSD;
    if(imp[2]==1){
        //double impSD[p_size];
        impSD = (double*)calloc(p_size, sizeof(double));
        if (DEBUG_ON) printf("impSD %d\n", p_size);
    }else{
        //double impSD=1;
        impSD = (double*)calloc(1, sizeof(double));
        if (DEBUG_ON) printf("impSD %d\n", 1);
        impSD[0]=0;
    }
    
    int keepf[2];
    keepf[0]=1;
    keepf[1]=0;
    
    int nt;
    if (keepf[0]==1){
        nt=ntree;
    }else{
        nt=1;
    }
    
    double prox[]={0};//[n_size*n_size]
    
    //int ndtree[ntree];
    int *ndtree; ndtree = (int*)calloc(ntree, sizeof(int));
    if (DEBUG_ON) printf("ntree %d\n", ntree);
    
    //int nodestatus[nrnodes * nt];
    SMALL_INT *nodestatus; nodestatus = (SMALL_INT*)calloc(nrnodes*nt, sizeof(SMALL_INT));
    if (DEBUG_ON) printf("nodestatus %d\n", nrnodes*nt);
    
    //int lDaughter[nrnodes * nt];
    int *lDaughter; lDaughter = (int*)calloc(nrnodes*nt, sizeof(int));
    if (DEBUG_ON) printf("lDau %d\n", nrnodes*nt);
    
    //int rDaughter[nrnodes * nt];
    int *rDaughter; rDaughter = (int*)calloc(nrnodes*nt, sizeof(int));
    if (DEBUG_ON) printf("rDau %d\n", nrnodes*nt);
    
    //double avnode[nrnodes * nt];
    double *avnode; avnode = (double*) calloc(nrnodes*nt, sizeof(double));
    if (DEBUG_ON) printf("avnode %d\n", nrnodes*nt);
    
    //int mbest[nrnodes * nt];
    int* mbest; mbest=(int*)calloc(nrnodes*nt, sizeof(int));
    if (DEBUG_ON) printf("mbest %d\n", nrnodes*nt);
    
    //double upper[nrnodes * nt];
    double *upper; upper = (double*) calloc(nrnodes*nt, sizeof(double));
    if (DEBUG_ON) printf("upper %d\n", nrnodes*nt);
    
    double *mse = (double*)calloc(ntree, sizeof(double));
    if (DEBUG_ON) printf("mse %f\n", mse);
    
    int replace=1;
    int testdat=0;
    double *xts=X;
    int nts = 10;
    double *yts=Y;
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
    double coef[2];
    
    //int nout[n_size];
    int*nout; nout=(int*)calloc(n_size, sizeof(int));
    
    int* inbag;
    if (keepf[1]==1){
        inbag=(int*)calloc(n_size*ntree, sizeof(int));
    }else{
        inbag=(int*)calloc(1, sizeof(int));
        inbag[0]=1;
    }
    
    //below call just prints individual values
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
            printf("%f,", X[i]);
        printf("\n");
    }
    
    //train the RF
    regRF(X, Y, dimx, &sampsize,
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
    
    //below call just prints individual values
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
    
    double* ypred = (double*)calloc(n_size,sizeof(double));
    
    if (DEBUG_ON){
        printf("predict: val's of first example: ");
        for(i=0;i<p_size;i++)
            printf("%f,", X[i]);
        printf("\n");
    }
    int mdim = p_size;
    
    double* xsplit=upper;
	double* avnodes=avnode;
	int* treeSize = ndtree;
	int keepPred=0;
	double allPred=0;
	double proxMat=0;
	int nodes=0;
	int *nodex; nodex=(int*)calloc(n_size,sizeof(int));
	
	//test the RF by sending the X matrix and asking it to label them
    regForest(X, ypred, &mdim, &n_size,
               &ntree, lDaughter, rDaughter,
               nodestatus, &nrnodes, xsplit,
               avnodes, mbest, treeSize, cat,
               maxcat, &keepPred, &allPred, doProx,
               &proxMat, &nodes, nodex);
    
    for(i=0;i<rows;i++)
       printf("%g\n", ypred[i]);
	
    
    //let the variables go free
    free(cat);
    free(y_pred_trn);
    free(impout);
    free(impmat);
    free(impSD);
    free(mse);
    free(yTestPred);
    free(msets);
    free(nout);
    free(inbag);
    
    //few of the below needs to be saved if prediction has to be done in a separate file
    free(ypred);
    free(nodex);
    free(ndtree);
    free(nodestatus);
    free(lDaughter);
    free(rDaughter);
    free(upper);
    free(avnode);
    free(mbest);
    
    printf("press any key to exit");
    getchar();
    //free the data matrix
    fclose(fp_X);
    fclose(fp_Y);
}




