% ********************************************************************
% * mex File compiling code for Random Forest (for linux)
% * mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
% * Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
% * License: GPLv2
% * Version: 0.02
% ********************************************************************/

function compile_windows
    system('del *.mexw32;del *.mexw64;');

    fprintf('I am going to use the precompiled fortran file\n');
    fprintf('If it doesnt work then use cygwin+g77 (or gfortran) to recompile rfsub.f\n');

    if strcmp(computer,'PCWIN64')
        mex  -DMATLAB -DWIN64 -output mexClassRF_train   src/classRF.cpp src/classTree.cpp src/cokus.cpp precompiled_rfsub/win64/rfsub.o src/mex_ClassificationRF_train.cpp   src/rfutils.cpp 
        mex  -DMATLAB -DWIN64 -output mexClassRF_predict src/classRF.cpp src/classTree.cpp src/cokus.cpp precompiled_rfsub/win64/rfsub.o src/mex_ClassificationRF_predict.cpp src/rfutils.cpp 
    elseif strcmp(computer,'PCWIN')
        mex  -DMATLAB -output mexClassRF_train   src/classRF.cpp src/classTree.cpp src/cokus.cpp precompiled_rfsub/win32/rfsub.o src/mex_ClassificationRF_train.cpp   src/rfutils.cpp 
        mex  -DMATLAB -output mexClassRF_predict src/classRF.cpp src/classTree.cpp src/cokus.cpp precompiled_rfsub/win32/rfsub.o src/mex_ClassificationRF_predict.cpp src/rfutils.cpp 
    else
        error('Wrong script to run on this Comp architecture. I cannot detect any windows system')
    end
    fprintf('Mex`s compiled correctly\n')