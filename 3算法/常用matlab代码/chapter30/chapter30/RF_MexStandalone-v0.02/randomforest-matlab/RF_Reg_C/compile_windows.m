% ********************************************************************
% * mex File compiling code for Random Forest (for windows)
% * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
% * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
% * License: GPLv2
% * Version: 0.02
% ********************************************************************/


function compile_windows

%need to do tricks for making Makfile run on windows as one needs cygwin.
%so instead use mex to compile everything up.

system('del *.mexw32;');

mex src/cokus.cpp src/reg_RF.cpp src/mex_regressionRF_train.cpp   -DMATLAB -output mexRF_train
mex src/cokus.cpp src/reg_RF.cpp src/mex_regressionRF_predict.cpp   -DMATLAB  -output mexRF_predict

fprintf('\n Mex`s compiled correctly\n')