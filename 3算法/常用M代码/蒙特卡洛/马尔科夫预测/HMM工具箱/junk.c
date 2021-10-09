
  m  = mxGetM(prhs[0]);
  n  = mxGetN(prhs[0]);
  pr = mxGetPr(prhs[0]);
  pi = mxGetPi(prhs[0]);
  cmplx = (pi == NULL ? 0 : 1);

  /* Allocate space for sparse matrix. 
   * NOTE:  Assume at most 20% of the data is sparse.  Use ceil
   * to cause it to round up. 
   */

  percent_sparse = 0.2;
  nzmax = (int)ceil((double)m*(double)n*percent_sparse);

  plhs[0] = mxCreateSparse(m,n,nzmax,cmplx);
  sr  = mxGetPr(plhs[0]);
  si  = mxGetPi(plhs[0]);
  irs = mxGetIr(plhs[0]);
  jcs = mxGetJc(plhs[0]);
    
  /* Copy nonzeros. */
  k = 0; 
  isfull = 0;
  for (j = 0; (j < n); j++) {
    int i;
    jcs[j] = k;
    for (i = 0; (i < m); i++) {
      if (IsNonZero(pr[i]) || (cmplx && IsNonZero(pi[i]))) {

        /* Check to see if non-zero element will fit in 
         * allocated output array.  If not, increase
         * percent_sparse by 10%, recalculate nzmax, and augment
         * the sparse array.
         */
        if (k >= nzmax) {
          int oldnzmax = nzmax;
          percent_sparse += 0.1;
          nzmax = (int)ceil((double)m*(double)n*percent_sparse);

          /* Make sure nzmax increases atleast by 1. */
          if (oldnzmax == nzmax) 
            nzmax++;

          mxSetNzmax(plhs[0], nzmax); 
          mxSetPr(plhs[0], mxRealloc(sr, nzmax*sizeof(double)));
          if (si != NULL)
          mxSetPi(plhs[0], mxRealloc(si, nzmax*sizeof(double)));
          mxSetIr(plhs[0], mxRealloc(irs, nzmax*sizeof(int)));

          sr  = mxGetPr(plhs[0]);
          si  = mxGetPi(plhs[0]);
          irs = mxGetIr(plhs[0]);
        }
        sr[k] = pr[i];
        if (cmplx) {
          si[k] = pi[i];
        }
        irs[k] = i;
        k++;
      }
    }
    pr += m;
    pi += m;
  }
  jcs[n] = k;
}
