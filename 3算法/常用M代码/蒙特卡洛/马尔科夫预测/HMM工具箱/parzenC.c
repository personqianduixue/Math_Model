/* C mex version of parzen.m
[B,B2] = parzen(feat, mu,  Sigma, Nproto); 
*/
#include "mex.h"
#include <stdio.h>
#include <math.h>

#define PI 3.141592654

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
  int    D, M, Q, T, d, m, q, t;
  double *data, *mu, *SigmaPtr, *N, Sigma;
  double *B, *dist, *B2, tmp;
  const int* dim_mu;
  double const1, const2, sum_m, sum_d, diff;
  int Dt, DMq, Dm, MQt, Mq;
  int dims_B2[3];

  int ndim_mu, i, save_B2;
  
  data = mxGetPr(prhs[0]);
  mu = mxGetPr(prhs[1]);
  SigmaPtr = mxGetPr(prhs[2]);
  Sigma = *SigmaPtr;
  N = mxGetPr(prhs[3]);
  
  D = mxGetM(prhs[0]);
  T = mxGetN(prhs[0]);

  ndim_mu = mxGetNumberOfDimensions(prhs[1]);
  dim_mu = mxGetDimensions(prhs[1]);
  D = dim_mu[0];
  M = dim_mu[1];
  /* printf("parzenC: nlhs=%d, D=%d, M=%d, T=%d\n", nlhs, D, M, T);  */

  /* If mu is mu(d,m,o,p), then [d M Q] = size(mu) in matlab sets Q=o*p,
     i.e.. the size of all conditioning variabeles */
  Q = 1;
  for (i = 2; i < ndim_mu; i++) {
    /* printf("dim_mu[%d]=%d\n", i, dim_mu[i]); */
    Q = Q*dim_mu[i];
  }

  /* M = max(N) */
  M = -1000000;
  for (i=0; i < Q; i++) {
    /* printf("N[%d]=%d\n", i, (int) N[i]); */
    if (N[i] > M) {
      M = (int) N[i];
    }
  }

  /*  printf("parzenC: nlhs=%d, D=%d, Q=%d, M=%d, T=%d\n", nlhs, D, Q, M, T); */

  plhs[0] = mxCreateDoubleMatrix(Q,T, mxREAL);
  B = mxGetPr(plhs[0]);

  if (nlhs >= 2)
    save_B2 = 1;
  else
    save_B2 = 0;
  
  if (save_B2) {
    /* printf("parzenC saving B2\n");  */
    /*plhs[1] = mxCreateDoubleMatrix(M*Q*T,1, mxREAL);*/
    dims_B2[0] = M;
    dims_B2[1] = Q;
    dims_B2[2] = T;
    plhs[1] = mxCreateNumericArray(3, dims_B2, mxDOUBLE_CLASS, mxREAL);
    B2 = mxGetPr(plhs[1]);
  } else {
    /* printf("parzenC not saving B2\n"); */
  }
  /*
  plhs[2] = mxCreateDoubleMatrix(M*Q*T,1, mxREAL);
  dist = mxGetPr(plhs[2]);
  */
  const1 = pow(2*PI*Sigma, -D/2.0);
  const2 = -(1/(2*Sigma));
 
  for (t=0; t < T; t++) {
    /* printf("t=%d!\n",t); */
    Dt  = D*t;
    MQt = M*Q*t;
    for (q=0; q < Q; q++) {
      sum_m = 0;
      DMq = D*M*q;
      Mq = M*q;

      for (m=0; m < (int)N[q]; m++) {
	sum_d = 0;
	Dm = D*m;
	for (d=0; d < D; d++) {
	  /* diff = data(d,t) - mu(d,m,q) */
	  /*diff = data[d + D*t] - mu[d + D*m + D*M*q]; */
	  diff = data[d + Dt] - mu[d + Dm + DMq];
	  sum_d = sum_d + diff*diff;
	}
	/* dist[m,q,t] = dist[m + M*q + M*Q*t] = dist[m + Mq + MQt] = sum_d */
	tmp = const1 * exp(const2*sum_d);
	sum_m = sum_m + tmp;
	if (save_B2)
	  B2[m + Mq + MQt] = tmp;
      }

      if (N[q]>0) {
	B[q + Q*t] = (1.0/N[q]) *  sum_m;
      } else {
	B[q + Q*t] = 0.0;
      }
    }
  }
}



