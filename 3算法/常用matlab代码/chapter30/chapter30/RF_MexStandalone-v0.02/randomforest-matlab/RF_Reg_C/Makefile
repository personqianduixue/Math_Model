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

CC=g++

# debug CFLAGS
CFLAGS=-g -fPIC -pg -O2 -lm #-Wall

# optimized CFLAGS
#CFLAGS=-msse3 -O3 -fPIC -funroll-loops -march=native -Wall -pg

#use below if using ICC and want to be fast :)
ICC_CFLAGS = $(CFLAGS) -mtune=core2 -fast
ICC_LDFLAGS=-limf -lsvml -lirc -L/opt/intel/Compiler/11.0/074/lib/intel64/


all:	clean mex diabetes
#gcc reg_RF.cpp -o regRF -lm -Wall $(CFLAGS) 
#gcc reg_RF.c -o regRF -lm -Wall $(ICC_CFLAGS)

SRC=src/
BUILD=tempbuild/
cokus_test:$(SRC)cokus.cpp $(SRC)cokus_test.cpp
	g++ $(SRC)cokus.cpp $(SRC)cokus_test.cpp -o cokus_test
 
diabetes:
	echo -e  'Compiling diabetes test case'
	g++  $(SRC)cokus.cpp $(SRC)reg_RF.cpp $(SRC)diabetes_C_wrapper.cpp $(CFLAGS) -o diabetes_test 

mex:	clean 
	echo -e 'Making mex'
	mex $(SRC)cokus.cpp $(SRC)mex_regressionRF_train.cpp $(SRC)reg_RF.cpp -o mexRF_train -DMATLAB 
	mex $(SRC)cokus.cpp $(SRC)mex_regressionRF_predict.cpp $(SRC)reg_RF.cpp -o mexRF_predict -DMATLAB 
#mex mex_regressionRF_train.c reg_RF.o -o mexRF_train -DMATLAB $(ICC_LDFLAGS)

reg_RF:
	$(CC) $(SRC)reg_RF.cpp -c $(CFLAGS) -o $(BUILD)reg_RF.o

clean:
	rm -rf *.mexa64 *.mexglx *.mexw32 *.o $(SRC)*.o $(BUILD)*.o *.exe *~ gmon* diabetes_test cokus_test a.out
	echo 'deleted mex files, object files, gmon files and diabetes_test'
