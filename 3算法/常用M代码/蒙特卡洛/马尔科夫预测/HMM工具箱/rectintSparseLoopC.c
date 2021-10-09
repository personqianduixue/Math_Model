/* This is based on
http://www.mathworks.com/access/helpdesk/help/techdoc/matlab_external/ch04cr12.shtml

See rectintSparse.m for the matlab version of this code.

*/

#include <math.h> /* Needed for the ceil() prototype. */
#include "mex.h"
#include <stdio.h>

/* If you are using a compiler that equates NaN to be zero, you 
 * must compile this example using the flag  -DNAN_EQUALS_ZERO.
 * For example:
 *
 *     mex -DNAN_EQUALS_ZERO fulltosparse.c
 *
 * This will correctly define the IsNonZero macro for your C
 * compiler.
 */

#if defined(NAN_EQUALS_ZERO)
#define IsNonZero(d) ((d) != 0.0 || mxIsNaN(d))
#else
#define IsNonZero(d) ((d) != 0.0)
#endif

#define MAX(x,y)  ((x)>(y) ? (x) : (y))
#define MIN(x,y)  ((x)<(y) ? (x) : (y))

void mexFunction(
        int nlhs,       mxArray *plhs[],
        int nrhs, const mxArray *prhs[]
        )
{
  /* Declare variables. */
  int j,k,m,n,nzmax,*irs,*jcs, *irs2, *jcs2;
  double *overlap, *overlap2, tmp, areaA, areaB;
  double percent_sparse;
  double *leftA, *rightA, *topA, *bottomA;
  double *leftB, *rightB, *topB, *bottomB;
  double *verbose;

  /* Get the size and pointers to input data. */
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

    /* Allocate space for sparse matrix. 
     * NOTE:  Assume at most 20% of the data is sparse.  Use ceil
     * to cause it to round up. 
     */

  percent_sparse = 0.01;
  nzmax = (int)ceil((double)m*(double)n*percent_sparse);

  plhs[0] = mxCreateSparse(m,n,nzmax,0);
  overlap  = mxGetPr(plhs[0]);
  irs = mxGetIr(plhs[0]);
  jcs = mxGetJc(plhs[0]);

  plhs[1] = mxCreateSparse(m,n,nzmax,0);
  overlap2  = mxGetPr(plhs[1]);
  irs2 = mxGetIr(plhs[1]);
  jcs2 = mxGetJc(plhs[1]);

    
  /* Assign nonzeros. */
  k = 0; 
  for (j = 0; (j < n); j++) {
    int i;
    jcs[j] = k; 
    jcs2[j] = k; 
    for (i = 0; (i < m); i++) {
      tmp = (MAX(0, MIN(rightA[i], rightB[j]) - MAX(leftA[i], leftB[j]) )) * 
	(MAX(0, MIN(topA[i], topB[j]) - MAX(bottomA[i], bottomB[j]) ));
      
      if (*verbose) {
	printf("j=%d,i=%d,tmp=%5.3f\n", j,i,tmp);
      }

      if (IsNonZero(tmp)) {

        /* Check to see if non-zero element will fit in 
         * allocated output array.  If not, increase
         * percent_sparse by 20%, recalculate nzmax, and augment
         * the sparse array.
         */
        if (k >= nzmax) {
          int oldnzmax = nzmax;
          percent_sparse += 0.2;
          nzmax = (int)ceil((double)m*(double)n*percent_sparse);

          /* Make sure nzmax increases atleast by 1. */
          if (oldnzmax == nzmax) 
            nzmax++;
	  printf("reallocating from %d to %d\n", oldnzmax, nzmax);

          mxSetNzmax(plhs[0], nzmax); 
          mxSetPr(plhs[0], mxRealloc(overlap, nzmax*sizeof(double)));
          mxSetIr(plhs[0], mxRealloc(irs, nzmax*sizeof(int)));
          overlap  = mxGetPr(plhs[0]);
          irs = mxGetIr(plhs[0]);

          mxSetNzmax(plhs[1], nzmax); 
          mxSetPr(plhs[1], mxRealloc(overlap2, nzmax*sizeof(double)));
          mxSetIr(plhs[1], mxRealloc(irs2, nzmax*sizeof(int)));
          overlap2  = mxGetPr(plhs[1]);
          irs2 = mxGetIr(plhs[1]);
        }

        overlap[k] = tmp;
        irs[k] = i;
	
	areaA = (rightA[i]-leftA[i])*(topA[i]-bottomA[i]);
	areaB = (rightB[j]-leftB[j])*(topB[j]-bottomB[j]);
	overlap2[k] = MIN(tmp/areaA, tmp/areaB);
	irs2[k] = i;

        k++;
      } /* IsNonZero */
    } /* for i */
  }
  jcs[n] = k;
  jcs2[n] = k;
  
}








