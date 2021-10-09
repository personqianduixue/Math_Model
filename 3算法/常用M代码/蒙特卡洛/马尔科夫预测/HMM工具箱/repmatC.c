/*
mex -c mexutil.c
mex repmat.c mexutil.obj
to check for warnings:
gcc -Wall -I/cygdrive/c/MATLAB6p1/extern/include -c repmat.c
*/
#include "mexutil.h"
#include <string.h>

/* repeat a block of memory rep times */
void memrep(char *dest, size_t chunk, int rep)
{
#if 0
  /* slow way */
  int i;
  char *p = dest;
  for(i=1;i<rep;i++) {
    p += chunk;
    memcpy(p, dest, chunk);
  }
#else
  /* fast way */
  if(rep == 1) return;
  memcpy(dest + chunk, dest, chunk); 
  if(rep & 1) {
    dest += chunk;
    memcpy(dest + chunk, dest, chunk);
  }
  /* now repeat using a block twice as big */
  memrep(dest, chunk<<1, rep>>1);
#endif
}

void repmat(char *dest, const char *src, int ndim, int *destdimsize, 
	    int *dimsize, const int *dims, int *rep) 
{
  int d = ndim-1;
  int i, chunk;
  /* copy the first repetition into dest */
  if(d == 0) {
    chunk = dimsize[0];
    memcpy(dest,src,chunk);
  }
  else {
    /* recursively repeat each slice of src */
    for(i=0;i<dims[d];i++) {
      repmat(dest + i*destdimsize[d-1], src + i*dimsize[d-1], 
	     ndim-1, destdimsize, dimsize, dims, rep);
    }
    chunk = destdimsize[d-1]*dims[d];
  }
  /* copy the result rep-1 times */
  memrep(dest,chunk,rep[d]);
}

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
  const mxArray *srcmat;
  int ndim, *dimsize, eltsize;
  const int *dims;
  int ndimdest, *destdims, *destdimsize;
  char *src, *dest;
  int *rep;
  int i,nrep;
  int extra_rep = 1;
  int empty;

  if(nrhs < 2) mexErrMsgTxt("Usage: xrepmat(A, [N M ...])");
  srcmat = prhs[0];
  if(mxIsSparse(srcmat)) {
    mexErrMsgTxt("Sorry, can't handle sparse matrices yet.");
  }
  if(mxIsCell(srcmat)) {
    mexErrMsgTxt("Sorry, can't handle cell arrays yet.");
  }
  ndim = mxGetNumberOfDimensions(srcmat);
  dims = mxGetDimensions(srcmat);
  eltsize = mxGetElementSize(srcmat);

  /* compute dimension sizes */
  dimsize = mxCalloc(ndim, sizeof(int));
  dimsize[0] = eltsize*dims[0];
  for(i=1;i<ndim;i++) dimsize[i] = dimsize[i-1]*dims[i];

  /* determine repetition vector */
  ndimdest = ndim;
  if(nrhs == 2) {
    nrep = mxGetN(prhs[1]);
    if(nrep > ndimdest) ndimdest = nrep;
    rep = mxCalloc(ndimdest, sizeof(int));
    for(i=0;i<nrep;i++) {
      double repv = mxGetPr(prhs[1])[i];
      rep[i] = (int)repv;
    }
    if(nrep == 1) {
      /* special behavior */
      nrep = 2;
      rep[1] = rep[0];
    }
  }
  else {
    nrep = nrhs-1;
    if(nrep > ndimdest) ndimdest = nrep;
    rep = mxCalloc(ndimdest, sizeof(int));
    for(i=0;i<nrep;i++) {
      rep[i] = (int)*mxGetPr(prhs[i+1]);
    }
  }
  for(i=nrep;i<ndimdest;i++) rep[i] = 1;

  /* compute output size */
  destdims = mxCalloc(ndimdest, sizeof(int));
  for(i=0;i<ndim;i++) destdims[i] = dims[i]*rep[i];
  for(;i<ndimdest;i++) { 
    destdims[i] = rep[i];
    extra_rep *= rep[i];
  }
  destdimsize = mxCalloc(ndim, sizeof(int));
  destdimsize[0] = eltsize*destdims[0];
  for(i=1;i<ndim;i++) destdimsize[i] = destdimsize[i-1]*destdims[i];

    
  /* for speed, array should be uninitialized */
  plhs[0] = mxCreateNumericArray(ndimdest, destdims, mxGetClassID(srcmat), 
				  mxIsComplex(srcmat)?mxCOMPLEX:mxREAL);

  /* if any rep[i] == 0, output should be empty array.
     Added by KPM 11/13/02.
  */
  empty = 0;
  for (i=0; i < nrep; i++) {
    if (rep[i]==0) 
      empty = 1;
  }
  if (empty) 
    return;

  src = (char*)mxGetData(srcmat);
  dest = (char*)mxGetData(plhs[0]);
  repmat(dest,src,ndim,destdimsize,dimsize,dims,rep);
  if(ndimdest > ndim) memrep(dest,destdimsize[ndim-1],extra_rep);
  if(mxIsComplex(srcmat)) {
    src = (char*)mxGetPi(srcmat);
    dest = (char*)mxGetPi(plhs[0]);
    repmat(dest,src,ndim,destdimsize,dimsize,dims,rep);
    if(ndimdest > ndim) memrep(dest,destdimsize[ndim-1],extra_rep);
  }
}
