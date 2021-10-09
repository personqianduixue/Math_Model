% ********************************************************************
% * mex File compiling code for Random Forest (for linux)
% * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
% * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
% * License: GPLv2
% * Version: 0.02
% ********************************************************************/
function compile_linux

    system('rm *.mexglx *.mexa64;');

    system('make clean;make mex;');
    
    %the fortran code makes it hard to NOT use the Makefile

    
