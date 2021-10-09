/**************************************************************
 * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
 * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
 * License: GPLv2
 * Version: 0.02
 *
 * Supporting file that has some declarations.
 *************************************************************/

#define uint32 unsigned long
#define SMALL_INT char

#ifdef MATLAB
#define SMALL_INT_CLASS mxCHAR_CLASS //will be used to allocate memory t
#endif

void seedMT(uint32 seed);
uint32 randomMT(void);

