#include "mex.h"

mxArray *mxCreateNumericArrayE(int ndim, const int *dims, 
			       mxClassID class, mxComplexity ComplexFlag);
mxArray *mxCreateNumericMatrixE(int m, int n, mxClassID class, 
				mxComplexity ComplexFlag);
mxArray *mxCreateDoubleMatrixE(int m, int n, 
			       mxComplexity ComplexFlag);
