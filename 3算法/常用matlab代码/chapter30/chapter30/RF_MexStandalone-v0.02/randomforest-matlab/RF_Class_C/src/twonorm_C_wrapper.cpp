/********************************************************************
 * Standalone interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 * 
 * What this barely has: link to Random forest code, setting parameters for
 * number of tree, nvar/mtry. No support for almost everything else.
 *
 * Uses the twonorm dataset, creating the RF models and
 * testing on the dataset. This is just a simple code to show the interface
 * with the code from Andy Liaw et al. Modify as needed for custom datasets
 *
 * In this default form it will output the predictions out.
 * use DEBUG_ON to control verbosity
 *
 * to compile on linux: use the Makefile command 'make twonorm'
 *
 * to compile on windows: use either cygwin or VC++ (<CC> represents the compiler)
 *  to compile these 5 files "cokus.cpp classRF.cpp twonorm_C_wrapper.cpp rfutils.cpp classTree.cpp"
 *  and also either compile or link with rfsub.f (need a fortran compiler)  or rfsub.o (precompiled)
 *
 * Errata: the file reading part will be needed to tweaked per requirement
 * 
 * Generating the ascii files:
 *  the data files can be generated from matlab as
 *  save('filename.mat','variable','-ascii')
 *******************************************************************/


#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

#define DEBUG_ON 1

void classRF(double *x, int *dimx, int *cl, int *ncl, int *cat, int *maxcat,
	     int *sampsize, int *strata, int *Options, int *ntree, int *nvar,
	     int *ipi, double *classwt, double *cut, int *nodesize,
	     int *outcl, int *counttr, double *prox,
	     double *imprt, double *impsd, double *impmat, int *nrnodes,
	     int *ndbigtree, int *nodestatus, int *bestvar, int *treemap,
	     int *nodeclass, double *xbestsplit, double *errtr,
	     int *testdat, double *xts, int *clts, int *nts, double *countts,
	     int *outclts, int labelts, double *proxts, double *errts,
             int *inbag);


void classForest(int *mdim, int *ntest, int *nclass, int *maxcat,
        int *nrnodes, int *ntree, double *x, double *xbestsplit,
        double *pid, double *cutoff, double *countts, int *treemap,
        int *nodestatus, int *cat, int *nodeclass, int *jts,
        int *jet, int *bestvar, int *node, int *treeSize,
        int *keepPred, int *prox, double *proxMat, int *nodes);

int main(){
    char X_filename[100], Y_filename[100];
    FILE *fp_X, *fp_Y, *fp;
    
    //set the number of examples in rows and number of dimensions in cols
    int cols=20,rows=300,i,j;
    
    /***START: NO NEED TO CHANGE ANYTHING FROM HERE TO THERE***************/
    int p_size=cols,n_size=rows;
    int nsample=n_size;
    
    //need the below for some string ops
    char dum_str[100];
    
    //allocate some memory for the data
    double* X=(double*)calloc(rows*cols,sizeof(double));
    int* Y=(int*)calloc(rows,sizeof(int));
    
    
    //the classifcation version requires {D,N}, where D=(num) dimensions, N=(num) examples
    int dimx[2];
    dimx[0]=p_size;
    dimx[1]=n_size;
    
    int* cat = (int*)calloc(p_size,sizeof(int));
    
    
    /***END: NO NEED TO CHANGE ANYTHING FROM HERE TO THERE*****************/
    
	
    //save the file to open in some string variables
    strcpy(X_filename,"data/X_twonorm.txt");
    strcpy(Y_filename,"data/Y_twonorm.txt");
    

    //write prediction OUTPUT into Y_hat.txt
//    fp = fopen("Y_hat.txt","w");
    
    
    /**read and save to the X and Y variable**
    **this file grabbing is different in the regression version as it seemed to work there
     *but not here :( */
    fp_X = fopen(X_filename,"r");
    fp_Y = fopen(Y_filename,"r");
    
    if (fp_X !=NULL)
    {
      if(DEBUG_ON) printf("file opened: %s\n",X_filename);
    }else{
      printf("cannot find files for data\n");exit(0);
    }
    
    if (fp_Y !=NULL)
    {
      if(DEBUG_ON) printf("file opened: %s\n",Y_filename);
    }else{
      printf("cannot find files for data\n");exit(0);
    }
    
    fflush(stdout);
    
    for(i=0;i<rows;i++)
      for(j=0;j<cols;j++){
         //fscanf(fp_X, "%f ", &X[i*cols+j]);
         fscanf(fp_X,"%s ",dum_str);
         X[i*cols+j]=atof(dum_str);
         if ((i*cols+j <10) & DEBUG_ON)
            printf("%s (%f)", dum_str,X[i*cols+j]);
         fflush(stdout);
      }
    
    /* optionally print something if you think there was an error in reading*/
    /*for(i=0;i<10;i++)
        printf("%f, ",X[i]);
  
    for(i=rows*cols-10;i<rows*cols;i++)
        printf("%f, ",X[i]);*/
  
    for(i=0;i<rows;i++){
       fscanf(fp_Y,"%s ",dum_str);
       Y[i] = (int)atof(dum_str);
       if (DEBUG_ON) printf("%d,",Y[i]);
    }
    /********************DONE with DATA reading***************************/
    
    //number of classes - <change appropriately>
    int nclass=2;
    
    //need to do set this else everything blows up, represents the number of categories for
    //every dimension - <change appropriately>
    for(i=0;i<p_size;i++) cat[i]=1; 
    
	fflush(stdout);//flush out any printf that we might have done till now
    
    //basically set the below to max(cat)
    int maxcat=1;//=max(cat)  - <change appropriately>
    
    int sampsize=n_size; //if replace then sampsize=n_size or sampsize=0.632*n_size
    
    //no need to change this
    int nsum = sampsize;
    
    int strata = 1;    
    //other options
    int addclass = 0;
    int importance=0;
    int localImp=0;
    int proximity=0;
    int oob_prox=0;
    int do_trace; //this variable prints verbosely each step
    if(DEBUG_ON)
       do_trace=1;
    else
       do_trace=0;
    int keep_forest=1;
    int replace=1;
    int stratify=0;
    int keep_inbag=0;
    int Options[]={addclass,importance,localImp,proximity,oob_prox
     ,do_trace,keep_forest,replace,stratify,keep_inbag};
    
     
    //ntree= number of tree. mtry=mtry :)
    int ntree=500; int nt=ntree;
    int mtry=(int)floor(sqrt(p_size)); //  - <change appropriately>
    if(DEBUG_ON) printf("ntree %d, mtry %d\n",ntree,mtry);
    
    int ipi=0;
    double* classwt=(double*)calloc(nclass,sizeof(double));
    double* cutoff=(double*)calloc(nclass,sizeof(double));
    for(i=0;i<nclass;i++){
        classwt[i]=1;
        cutoff[i]=1.0/((double)nclass);
    }
    int nodesize=1;
    int* outcl=(int*) calloc(nsample,sizeof(int));
    int* counttr=(int*) calloc(nclass*nsample,sizeof(int));
    double prox=1;
    double* impout=(double*)calloc(p_size,sizeof(double));
    double impSD=1;
    double impmat=1; 
    int nrnodes = 2 * (int)floor(nsum / nodesize) + 1;
    int* ndbigtree = (int*) calloc(ntree,sizeof(int)); 
    int* nodestatus = (int*) calloc(nt*nrnodes,sizeof(int));
    int* bestvar = (int*) calloc(nt*nrnodes,sizeof(int));
    int* treemap = (int*) calloc(nt * 2 * nrnodes,sizeof(int));
    int* nodepred = (int*) calloc(nt * nrnodes,sizeof(int));
    double* xbestsplit = (double*) calloc(nt * nrnodes,sizeof(double));
    double* errtr = (double*) calloc((nclass+1) * ntree,sizeof(double));
    int testdat=0;
    double xts=1;
    int clts = 1; 
    int nts=0;
    double* countts = (double*) calloc(nclass * nts,sizeof(double));
    int outclts = 0;
    int labelts=0;
    double proxts=1;
    double errts=1;
    int* inbag = (int*) calloc(n_size,sizeof(int));

    //printf("1");
    fflush(stdout);
    //printf("2");
    
    //train the model
    classRF(X, dimx, Y, &nclass, cat, &maxcat,
	     &sampsize, &strata, Options, &ntree, &mtry,&ipi, 
         classwt, cutoff, &nodesize,outcl, counttr, &prox,
	     impout, &impSD, &impmat, &nrnodes,ndbigtree, nodestatus, 
         bestvar, treemap,nodepred, xbestsplit, errtr,&testdat, 
         &xts, &clts, &nts, countts,&outclts, labelts, 
         &proxts, &errts,inbag);
    
    
    //test the model
    //classwt=pid
    //printf("3");
    int ntest = n_size;
    double *pid = classwt;
    free(countts);
    countts = (double*) calloc(nclass * ntest,sizeof(double));
    //nodeclass=nodepred
    int* nodeclass = nodepred;
    int* jts = (int*) calloc(ntest,sizeof(int));
    int* jet = (int*) calloc(ntest,sizeof(int));
    int* treeSize = ndbigtree;
    int keepPred=0;
    int intProximity=0;
    int nodes=0;
    int* nodexts;
    if (nodes)
        nodexts = (int*)calloc(ntest*ntree,sizeof(int));
    else
        nodexts = (int*)calloc(ntest,sizeof(int));
    int* node = nodexts;
    double *proxMat;
    if(proximity)
        proxMat = (double*)calloc(ntest*ntest,sizeof(double));
    else
        proxMat = (double*)calloc(1,sizeof(double));
    //printf("4");
    
    classForest(&p_size, &ntest, &nclass, &maxcat,
        &nrnodes, &ntree, X, xbestsplit,
        pid, cutoff, countts, treemap,
        nodestatus, cat, nodeclass, jts,
	jet, bestvar, node, treeSize,
        &keepPred, &intProximity, proxMat, &nodes);
    //printf("5");
    
    if(DEBUG_ON) printf("Predicted class Labels\n");
    for(i=0;i<n_size;i++){
//        fprintf(fp,"%d\n",jts[i]);
        printf("%d\n",jts[i]);
    }
    int total_error=0;
    
    
    
    for(i=0;i<n_size;i++)
        if(jts[i]!=Y[i])
            total_error+=1;
    
    if (DEBUG_ON)
        printf("\nTotal misclassified %d out of %d\n",total_error,n_size);
    
    if (DEBUG_ON){
        printf("Press any key to end");
        getchar();
    }
    free(X);
    free(Y);
    
    free(jet);
    free(jts);
    free(nodexts);
    free(proxMat);
    free(cat);
    free(classwt);
    free(cutoff);
    free(outcl);
    free(counttr);
    free(ndbigtree);
    free(nodestatus);
    free(bestvar);
    free(treemap);
    free(nodepred);
    free(xbestsplit);
    free(errtr);
    free(countts);
    free(inbag);
    free(impout);
    
    
    fflush(stdout);
    fclose(fp_Y);
    fclose(fp_X);
//    fclose(fp);
}

