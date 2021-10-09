mex/standalone interface to Andy Liaw et al.'s C code (used in R package randomForest)
Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
License: GPLv2
Version: 0.02


CLASSIFICATION BASED RANDOMFOREST


****A tutorial for matlab now in tutorial_ClassRF.m****
 

Ways to generate Mex's and Standalone files

rfsub.o is compiled using fortran from rfsub.f. In case cywin or a fortran
compiler is not present just copy the appropriate (depending on OS)
rfsub.o from precompiled_rfsub directory to the current directory


___STANDALONE____ (not exactly standalone but an interface via C)
An example for a C file using the twonorm dataset for classification
is shown in src/twonorm_C_wrapper.cpp

This is a standalone version that needs to set right parameters in CPP file. 

Compiling in windows:
Method 1: use cygwin and make: go to current directory and run 'make twonorm -f Makefile.windows' 
in cygwin command prompt.  Need to have gcc/g++ and g77 (in cygwin)
 installed. Also the custom makefile differs from the linux version which has -lgfortran
whereas the windows version doesn't. Will generate twonorm_test.exe

Method 2: use DevC++ (download from http://www.bloodshed.net/devcpp.html ). 
Open the twonorm_C_devc.dev file which is a project file which has the sources 
etc set. Just compile and run. Will generate twonorm_C_devcpp.exe

Compiling in linux:
Method 1: use linux and make: go to this directory and run 'make diabetes' 
in command prompt. Need to have gcc/g++ and fortran installed. Will generate diabetes_test. 
run as ./diabetes_test


___MATLAB___
generates Mex files that can be called in Matlab directly.

Compiling in windows:
Use the compile_windows.m and run in windows. It will compile and generate 
appropriate mex files. Need Visual C++ or some other compiler 
(VC++ express edition also works). Won't work with Matlab's inbuilt compiler (lcc)


Compiling in linux:
Use the compile_linux.m and run in windows. It will compile and generate 
appropriate mex files. 

Using the Mex interface:
There are 2 functions classRF_train and classRF_predict as given below.
See the sample file test_ClassRF_extensively.m


%function Y_hat = classRF_predict(X,model)
    %requires 2 arguments
    %X: data matrix
    %model: generated via classRF_train function

%function model = classRF_train(X,Y,ntree,mtry, extra_options)
    %requires 2 arguments and the rest 2 are optional
    %X: data matrix
    %Y: target values
    %ntree (optional): number of trees (default is 500)
    %mtry (default is max(floor(D/3),1) D=number of features in X)
    %there are about 14 odd options for extra_options. Refer to tutorial_ClassRF.m to examine them

Version History:
  v0.02 (May-15-09):Updated so that classification package now has about 95% of the total options
        that the R-package gives. Woohoo. Tracing of what happening behind screen works better.
  v0.01 (Mar-22-09): very basic interface for mex/standalone to Liaw et al's 
     randomForest Package supports only ntree and mtry changing for time being.
    