#include "mexutil.h"

/* Functions to create uninitialized arrays. */

mxArray *mxCreateNumericArrayE(int ndim, const int *dims, 
         mxClassID class, mxComplexity ComplexFlag)
{
  mxArray *a;
  int i, *dims1 = mxMalloc(ndim*sizeof(int));
  size_t sz = 1;
  for(i=0;i<ndim;i++) {
    sz *= dims[i];
    dims1[i] = 1;
  }
  a = mxCreateNumericArray(ndim,dims1,class,ComplexFlag);
  sz *= mxGetElementSize(a);
  mxSetDimensions(a, dims, ndim);
  mxFree(dims1);
  mxSetData(a, mxRealloc(mxGetData(a), sz));
  if(ComplexFlag == mxCOMPLEX) {
    mxSetPi(a, mxRealloc(mxGetPi(a),sz));
  }
  return a;
}
mxArray *mxCreateNumericMatrixE(int m, int n, mxClassID class, 
				mxComplexity ComplexFlag)
{
  size_t sz = m*n*sizeof(double);
  mxArray *a = mxCreateNumericMatrix(1, 1, class, ComplexFlag);
  mxSetM(a,m);
  mxSetN(a,n);
  mxSetPr(a, mxRealloc(mxGetPr(a),sz));
  if(ComplexFlag == mxCOMPLEX) {
    mxSetPi(a, mxRealloc(mxGetPi(a),sz));
  }
  return a;
}
mxArray *mxCreateDoubleMatrixE(int m, int n, 
			       mxComplexity ComplexFlag)
{
  return mxCreateNumericMatrixE(m,n,mxDOUBLE_CLASS,ComplexFlag);
}

