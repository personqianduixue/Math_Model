/* C mex version of ind2subv.m in misc directory */
/* 2 input, 1 output         */
/* siz, ndx                  */
/* sub                       */

#include "mex.h"
#include <math.h>

void rbinary(int num, int n, double *rbits){
	int i, mask;
	num = num - 1;

	mask = 1 << (n-1); /* mask = 00100...0 , where the 1 is in column n (rightmost = col 1) */
	for (i = 0; i < n; i++) {
		rbits[n-i-1] = ((num & mask) == 0) ? 1 : 2;
		num <<= 1;
	}
}

void ind_subv(int num, const double *sizes, int n, double *rbits){
	int i;
	int *cumprod;

	cumprod  = malloc(n * sizeof(int));
	num = num - 1;
	cumprod[0] = 1;
	for (i = 0; i < n-1; i++)
	cumprod[i+1] = cumprod[i] * (int)sizes[i];
	for (i = n-1; i >= 0; i--) {
		rbits[i] = ((int)floor(num / cumprod[i])) + 1;
		num = num % cumprod[i];
	}
	free(cumprod);
}


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
	int    i, j, k, nCol, nRow, nnRow, binary, count, temp, temp1, start;
	double *pSize, *pNdx, *pr;
	double ndx;
	int    *subv, *cumprod, *templai;

	pSize = mxGetPr(prhs[0]);
	pNdx = mxGetPr(prhs[1]);
	nCol = mxGetNumberOfElements(prhs[0]);
	nnRow = mxGetNumberOfElements(prhs[1]);

	nRow = 1;
	for(i=0; i<nCol; i++){
		nRow *= (int)pSize[i];
	}

	if(nCol == 0){
		plhs[0] = mxDuplicateArray(prhs[1]);
		return;
	}

	binary = 2;
	for (i = 0; i < nCol; i++){
		if (pSize[i] > 2.0){
			binary = 0;
			break;
		}
		else if((int)pSize[i] == 1){
			binary = 1;
		}
	}

	if(nnRow == 1){
		ndx = mxGetScalar(prhs[1]);
		plhs[0] = mxCreateDoubleMatrix(1, nCol, mxREAL);
		pr = mxGetPr(plhs[0]);
		if(binary == 2)rbinary((int)ndx, nCol, pr);
		else ind_subv((int)ndx, pSize, nCol, pr);
		return;
	}

	plhs[0] = mxCreateDoubleMatrix(nnRow, nCol, mxREAL);
	pr = mxGetPr(plhs[0]);

	subv = malloc(nRow * nCol * sizeof(int));

	if (binary == 2) {
		for(j=0; j<nCol; j++){
			temp = (1 << j);
			temp1 = j * nRow;
			for(i=0; i<nRow; i++){
				subv[temp1 + i] = ((i & temp) == 0) ? 1 : 2;
			}
		}
	}
	else if(binary == 1){
		cumprod = (int *)malloc(nCol * sizeof(int));
		templai = (int *)malloc(nCol * sizeof(int));
		cumprod[0] = 1;
		templai[0] = nRow;
		for(i=1; i<nCol; i++){
			k = (int)pSize[i-1] - 1;
			cumprod[i] = cumprod[i-1] << k;
			templai[i] = templai[i-1] >> k;
		}
		for(j=0; j<nCol; j++){
			temp1 = j * nRow;
			if(pSize[j] == 1.0){
				for(i=0; i<nRow; i++){
					subv[temp1 + i] = 1;
				}
			}
			else{
				temp = 1;
				count = 0;
				for(i=0; i<templai[j]; i++){
					if(temp > 2) temp = 1;
					for(k=0; k<cumprod[j]; k++){
						subv[temp1 + count] = temp;
                        count++;
					}
					temp++;
				}
			}
		}
		free(templai);
		free(cumprod);
	}
	else {
		cumprod = (int *)malloc(nCol * sizeof(int));
		templai = (int *)malloc(nCol * sizeof(int));
		cumprod[0] = 1;
		for(i=1; i<nCol; i++){
			cumprod[i] = (int)(cumprod[i-1] * pSize[i-1]);
		}
		templai[0] = nRow;
		for(i=1; i<nCol; i++){
			templai[i] = nRow / cumprod[i];
		}
		for(j=0; j<nCol; j++){
			temp1 = j * nRow;
			if(pSize[j] == 1.0){
				for(i=0; i<nRow; i++){
					subv[temp1 + i] = 1;
				}
			}
			else{
				temp = 1;
				count = 0;
				for(i=0; i<templai[j]; i++){
					if(temp > (int)pSize[j]) temp = 1;
					for(k=0; k<cumprod[j]; k++){
						subv[temp1 + count] = temp;
						count++;
					}
					temp++;
				}
			}
		}
		free(cumprod);
		free(templai);
	}

	count = 0;
	for(j=0; j<nCol; j++){
		temp1 = j * nRow;
		for(i=0; i<nnRow; i++){
			start = (int)pNdx[i] - 1;
			pr[count] = subv[temp1 + start];
			count++;
		}
	}
	free(subv);
}






