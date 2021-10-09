
#include "mex.h"
#include <stdio.h>

#define MAX(x,y)  ((x)>(y) ? (x) : (y))
#define MIN(x,y)  ((x)<(y) ? (x) : (y))

void mexFunction(
        int nlhs,       mxArray *plhs[],
        int nrhs, const mxArray *prhs[]
        )
{
  int j,k,m,n,nzmax,*irs,*jcs, *irs2, *jcs2;
  double *overlap, *overlap2, tmp, areaA, areaB;
  double *leftA, *rightA, *topA, *bottomA;
  double *leftB, *rightB, *topB, *bottomB;
  double *verbose;

  m = MAX(mxGetM(prhs[0]), mxGetN(prhs[0]));
  n = MAX(mxGetM(prhs[4]), mxGetN(prhs[4]));
  /* printf("A=%d, B=%d\n", m, n); */

  leftA = mxGetPr(prhs[0]);
  rightA = mxGetPr(prhs[1]);
  topA = mxGetPr(prhs[2]);
  bottomA = mxGetPr(prhs[3]);

  leftB = mxGetPr(prhs[4]);
  rightB = mxGetPr(prhs[5]);
  topB = mxGetPr(prhs[6]);
  bottomB = mxGetPr(prhs[7]);

  verbose = mxGetPr(prhs[8]);

  plhs[0] = mxCreateDoubleMatrix(m,n, mxREAL);
  overlap  = mxGetPr(plhs[0]);

  plhs[1] = mxCreateDoubleMatrix(m,n, mxREAL);
  overlap2  = mxGetPr(plhs[1]);

  k = 0; 
  for (j = 0; (j < n); j++) {
    int i;
    for (i = 0; (i < m); i++) {
      tmp = (MAX(0, MIN(rightA[i], rightB[j]) - MAX(leftA[i], leftB[j]) )) * 
	(MAX(0, MIN(topA[i], topB[j]) - MAX(bottomA[i], bottomB[j]) ));

      if (tmp > 0) {
	overlap[k] = tmp;
	
	areaA = (rightA[i]-leftA[i])*(topA[i]-bottomA[i]);
	areaB = (rightB[j]-leftB[j])*(topB[j]-bottomB[j]);
	overlap2[k] = tmp/MIN(areaA, areaB);
	
	if (*verbose) {
	  printf("j=%d,i=%d,overlap=%5.3f, norm=%5.3f\n", j,i, overlap[k], overlap2[k]);
	}
      }

      k++;
    }
  }
}








