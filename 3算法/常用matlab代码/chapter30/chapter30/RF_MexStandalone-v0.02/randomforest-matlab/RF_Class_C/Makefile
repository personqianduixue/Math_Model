# Makefile to compile mex/standalone version to Andy Liaw et al.'s C code (used in R package randomForest)
# Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
# License: GPLv2
# Version: 0.02


#  Makefile to generate mex or standalone. will work in cygwin (for windows) or linux
#
#  make mex: generates matlab mex files which can be easily called up
#  make diabetes: generates a standalone file to test on the pima indian
#                 diabetes dataset.
#


#source directory
SRC=src/

#temporary .o output directory
BUILD=tempbuild/

CC=g++
FORTRAN=gfortran # or g77 whichever is present
CFLAGS= -fpic -O2 -funroll-loops -msse3#-g -Wall
FFLAGS=-O2 -fpic #-g
LDFORTRAN=#-gfortran
MEXFLAGS=-g
all:	clean classTree cokus rfsub rfutils classRF twonorm mex
#all:	 regTree regrf rf rfsub rfutils classTree shared mex-setup

mex:	clean classTree  cokus rfsub rfutils mex_classRF

twonorm:  clean cokus classTree rfsub rfutils
	echo 'Generating twonorm executable'
	$(CC) $(CFLAGS) -c $(SRC)classRF.cpp -o $(BUILD)classRF.o
	$(CC) $(CFLAGS) $(SRC)twonorm_C_wrapper.cpp $(SRC)classRF.cpp $(BUILD)classTree.o $(BUILD)rfutils.o rfsub.o $(BUILD)cokus.o  -o twonorm_test -lgfortran -lm

mex_classRF: $(SRC)classRF.cpp  $(SRC)mex_ClassificationRF_train.cpp $(SRC)mex_ClassificationRF_predict.cpp
	echo 'Generating Mex'
#	mex -c $(SRC)classRF.cpp -outdir $(BUILD)classRF.o -DMATLAB $(MEXFLAGS)
	mex $(SRC)mex_ClassificationRF_train.cpp  $(SRC)classRF.cpp $(BUILD)classTree.o $(BUILD)rfutils.o rfsub.o $(BUILD)cokus.o  -o mexClassRF_train -lgfortran -lm -DMATLAB $(MEXFLAGS)
	mex $(SRC)mex_ClassificationRF_predict.cpp $(SRC)classRF.cpp $(BUILD)classTree.o $(BUILD)rfutils.o rfsub.o $(BUILD)cokus.o  -o mexClassRF_predict -lgfortran -lm -DMATLAB $(MEXFLAGS)

cokus: $(SRC)cokus.cpp
	echo 'Compiling Cokus (random number generator)'
	$(CC) $(CFLAGS) -c $(SRC)cokus.cpp -o $(BUILD)cokus.o

classRF:  $(SRC)classRF.cpp
	$(CC) $(CFLAGS) -c $(SRC)classRF.cpp -o $(BUILD)classRF.o
#	$(CC) $(CFLAGS) classRF.o classTree.o rfutils.o rfsub.o cokus.o  -o classRF $(LDFORTRAN) 

classTree: $(SRC)classTree.cpp 
	echo 'Compiling classTree.cpp'
	$(CC) $(CFLAGS) -c $(SRC)classTree.cpp -o $(BUILD)classTree.o 
	

rfsub:	$(SRC)rfsub.f
	echo 'Compiling rfsub.f (fortran subroutines)'
	$(FORTRAN)  $(FFLAGS) -c $(SRC)rfsub.f -o rfsub.o
#for compiling via a cross compiler for 64 bit
#	x86_64-pc-mingw32-gfortran -c $(SRC)rfsub.f -o rfsub.o
	
rfutils: $(SRC)rfutils.cpp
	echo 'Compiling rfutils.cpp'
	$(CC) $(CFLAGS) -c $(SRC)rfutils.cpp -o $(BUILD)rfutils.o


clean:	
	rm twonorm_test -rf
	rm  $(BUILD)*.o *.o -rf
	rm *~ -rf
	rm *.mexw32 twonorm_test -rf
	rm *.mexa64 -rf
	rm classRF -rf
	rm *.exe -rf
