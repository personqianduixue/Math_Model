/* C mex version of subv2ind*/
/* 2 inputs, 1 output       */
/* siz, subv                */
/* ndx                      */
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
	int    i, j, k, nCol, nRow, binary, temp;
	double *pSize, *pSubv, *pr;
	int    *cumprod;

	pSize = mxGetPr(prhs[0]);
	pSubv = mxGetPr(prhs[1]);
	nCol  = mxGetNumberOfElements(prhs[0]);
	nRow  = mxGetM(prhs[1]);

	
	if(mxIsEmpty(prhs[1])){
		plhs[0] = mxCreateDoubleMatrix(0, 0, mxREAL);
		return;
	}

	if(mxIsEmpty(prhs[0])){
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
		*mxGetPr(plhs[0]) = 1;
		return;
	}

	binary = 2;
	for (i = 0; i < nCol; i++){
		if (pSize[i] > 2.0){
			binary = 0;
			break;
		}
		else if(pSize[i] == 1.0){
			binary = 1;
		}
	}

	plhs[0] = mxCreateDoubleMatrix(nRow, 1, mxREAL);
	pr = mxGetPr(plhs[0]);
	for(i=0; i<nRow; i++){
		pr[i] = 1.0;
	}

	if (binary == 2){
		for(j=0; j<nCol; j++){
			temp = j * nRow;
			for(i=0; i<nRow; i++){
				pr[i] += ((int)pSubv[temp + i] - 1) << j;
			}
		}
	}
	else if(binary == 1){	
		cumprod = malloc(nCol * sizeof(int));
		cumprod[0] = 1;
		for(i=1; i<nCol; i++){
			k = (int)pSize[i-1] - 1;
			cumprod[i] = cumprod[i-1] << k;
		}
		for(j=0; j<nCol; j++){
			temp = j * nRow;
			for(i=0; i<nRow; i++){
				k = (int)pSubv[temp + i] - 1;
				if(k)pr[i] += cumprod[j];
			}
		}
		free(cumprod);
	}
	else {
		cumprod = malloc(nCol * sizeof(int));
		cumprod[0] = 1;
		for(i=1; i<nCol; i++){
			k = (int)pSize[i-1];
			cumprod[i] = cumprod[i-1] * k;
		}
		for(j=0; j<nCol; j++){
			temp = j * nRow;
			for(i=0; i<nRow; i++){
				k = (int)pSubv[temp + i] - 1;
				pr[i] += cumprod[j] * k;
			}
		}
		free(cumprod);
	}
}



