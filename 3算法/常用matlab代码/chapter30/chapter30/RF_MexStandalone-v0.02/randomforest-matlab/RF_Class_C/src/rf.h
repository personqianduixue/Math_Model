/**************************************************************
 * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 *
 * other than adding the macros for F77_* and adding this message
 * nothing changed .
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
#ifndef RF_H
#define RF_H

/* test if the bit at position pos is turned on */
#define isBitOn(x,pos) (((x) & (1 << (pos))) > 0)
/* swap two integers */
#define swapInt(a, b) ((a ^= b), (b ^= a), (a ^= b))
/*
void classRF(double *x, int *dimx, int *cl, int *ncl, int *cat, int *maxcat, 
	int *sampsize, int *Options, int *ntree, int *nvar,
	int *ipi, double *pi, double *cut, int *nodesize, 
        int *outcl, int *counttr, double *prox, 
	double *imprt, double *, double *impmat, int *nrnodes, int *ndbigtree, 
	int *nodestatus, int *bestvar, int *treemap, int *nodeclass,
	double *xbestsplit, double *pid, double *errtr, 
	int *testdat, double *xts, int *clts, int *nts, double *countts,
	int *outclts, int *labelts, double *proxts, double *errts);
*/

#define F77_CALL(x) x ## _
#define F77_NAME(x) F77_CALL(x)
#define F77_SUB(x) F77_CALL(x)


void normClassWt(int *cl, const int nsample, const int nclass, 
                 const int useWt, double *classwt, int *classFreq);

void classForest(int *mdim, int *ntest, int *nclass, int *maxcat, 
                 int *nrnodes, int *jbt, double *xts, double *xbestsplit, 
                 double *pid, double *cutoff, double *countts, int *treemap, 
                 int *nodestatus, int *cat, int *nodeclass, int *jts, 
                 int *jet, int *bestvar, int *nodexts, int *ndbigtree, 
                 int *keepPred, int *prox, double *proxmatrix, int *nodes);

void regTree(double *x, double *y, int mdim, int nsample, 
	     int *lDaughter, int *rDaughter, double *upper, double *avnode, 
             int *nodestatus, int nrnodes, int *treeSize, int nthsize, 
             int mtry, int *mbest, int *cat, double *tgini, int *varUsed);

void findBestSplit(double *x, int *jdex, double *y, int mdim, int nsample, 
		   int ndstart, int ndend, int *msplit, double *decsplit, 
		   double *ubest, int *ndendl, int *jstat, int mtry,
		   double sumnode, int nodecnt, int *cat);

void predictRegTree(double *x, int nsample, int mdim, 
		    int *lDaughter, int *rDaughter, int *nodestatus, 
                    double *ypred, double *split, double *nodepred, 
                    int *splitVar, int treeSize, int *cat, int maxcat,
                    int *nodex);

void predictClassTree(double *x, int n, int mdim, int *treemap,
		      int *nodestatus, double *xbestsplit,
		      int *bestvar, int *nodeclass,
		      int ndbigtree, int *cat, int nclass,
		      int *jts, int *nodex, int maxcat);

int pack(int l, int *icat);
void unpack(unsigned int npack, int *icat);

void zeroInt(int *x, int length);
void zeroDouble(double *x, int length);
void createClass(double *x, int realN, int totalN, int mdim);
void prepare(int *cl, const int nsample, const int nclass, const int ipi, 
	     double *pi, double *pid, int *nc, double *wtt);
void makeA(double *x, const int mdim, const int nsample, int *cat, int *a, 
           int *b);
void modA(int *a, int *nuse, const int nsample, const int mdim, int *cat, 
          const int maxcat, int *ncase, int *jin);
void Xtranslate(double *x, int mdim, int nrnodes, int nsample, 
		int *bestvar, int *bestsplit, int *bestsplitnext,
		double *xbestsplit, int *nodestatus, int *cat, int treeSize);
void permuteOOB(int m, double *x, int *in, int nsample, int mdim);
void computeProximity(double *prox, int oobprox, int *node, int *inbag, 
                      int *oobpair, int n);

/* Template of Fortran subroutines to be called from the C wrapper */
/*extern void F77_NAME(buildtree)(int *a, int *b, int *cl, int *cat, 
				int *maxcat, int *mdim, int *nsample, 
				int *nclass, int *treemap, int *bestvar, 
				int *bestsplit, int *bestsplitnext, 
				double *tgini, int *nodestatus, int *nodepop, 
				int *nodestart, double *classpop, 
				double *tclasspop, double *tclasscat, 
				int *ta, int *nrnodes, int *, 
				int *, int *, int *, int *, int *, int *, 
				double *, double *, double *,
				int *, int *, int *); 
*/
/* Node status */
#define NODE_TERMINAL -1
#define NODE_TOSPLIT  -2
#define NODE_INTERIOR -3

#endif /* RF_H */
