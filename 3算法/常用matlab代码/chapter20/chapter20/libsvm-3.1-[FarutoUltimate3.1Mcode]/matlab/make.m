% This make.m is used under Windows

% add -largeArrayDims on 64-bit machines

mex -O -largeArrayDims -I..\ -c ..\svm.cpp
mex -O -largeArrayDims -I..\ -c svm_model_matlab.c
mex -O -largeArrayDims -I..\ svmtrain.c svm.obj svm_model_matlab.obj
mex -O -largeArrayDims -I..\ svmpredict.c svm.obj svm_model_matlab.obj
mex -O -largeArrayDims libsvmread.c
mex -O -largeArrayDims libsvmwrite.c
