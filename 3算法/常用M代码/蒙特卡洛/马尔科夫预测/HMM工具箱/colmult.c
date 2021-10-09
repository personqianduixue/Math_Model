#include <stdio.h>
#include "mex.h"

/*
out = colop(M, v)

Apply binary operator to a vector v and to each column of M in turn
to produce a matrix the same size as M.

This is equivalent to

out = zeros(size(M));
for col=1:size(M,2)
  out(:,col) = op(M(:,col), v);
end

The code needs to be modified for each different operator 'op'.
eg op = '.*'

In vectorized form:

out = M .* repmat(v(:), 1, size(M,2))

(This function was formerly called repmat_and_mult.c)

*/

/* M(i,j) = M(i + nrows*j) since Matlab uses Fortran layout. */

 
#define INMAT(i,j) M[(i)+nrows*(j)]
#define OUTMAT(i,j) out[(i)+nrows*(j)]

void mexFunction(
                 int nlhs,       mxArray *plhs[],
                 int nrhs, const mxArray *prhs[]
		 )
{
  double *out, *M, *v;
  int nrows, ncols, r, c;
  
  /* read the input args */
  M = mxGetPr(prhs[0]);
  nrows = mxGetM(prhs[0]);
  ncols = mxGetN(prhs[0]);

  v = mxGetPr(prhs[1]);

  plhs[0] = mxCreateDoubleMatrix(nrows, ncols, mxREAL);
  out = mxGetPr(plhs[0]); 

  for (c=0; c < ncols; c++) {
    for (r=0; r < nrows; r++) {
      OUTMAT(r,c) = INMAT(r,c) * v[r]; 
      /* printf("r=%d, c=%d, M=%f, v=%f\n", r, c, INMAT(r,c), v[r]);  */
    }
  }

}



