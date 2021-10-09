/* C mex version of normalise.m in misc directory  */

#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  double *T, *sum_ptr, sum;
  int i, N;  

  plhs[0] = mxDuplicateArray(prhs[0]);
  T = mxGetPr(plhs[0]);
  if(mxIsSparse(plhs[0])) N = mxGetJc(plhs[0])[mxGetN(plhs[0])];
  else N = mxGetNumberOfElements(plhs[0]);

  plhs[1] = mxCreateDoubleMatrix(1, 1, mxREAL);
  sum_ptr = mxGetPr(plhs[1]);

  sum = 0;
  for (i = 0; i < N; i++) {
    sum += *T++;
  }
  T = mxGetPr(plhs[0]);
  if (sum > 0) {
    for (i = 0; i < N; i++) {
      *T++ /= sum;
    }
  } 
  *sum_ptr = sum;
}
