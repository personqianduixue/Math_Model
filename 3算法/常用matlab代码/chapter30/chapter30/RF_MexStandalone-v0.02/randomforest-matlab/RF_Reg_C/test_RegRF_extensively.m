%**************************************************************
%* Test of mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
%* Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
%* License: GPLv2
%* Version: 0.02
%
%  This file runs tests about 10 times on the diabetes dataset
%
%**************************************************************

%compile everything
if strcmpi(computer,'PCWIN') |strcmpi(computer,'PCWIN64')
   compile_windows
else
   compile_linux
 end  

load data/diabetes

%diabetes, N=442, D=10
total_train_time=0;
total_test_time=0;
for i=1:10
	fprintf('%d,',i);
	tic;
	model=regRF_train(diabetes.x,diabetes.y,1000);
	total_train_time=toc;
	tic;
	y_hat =regRF_predict(diabetes.x,model);
	total_test_time=total_test_time+toc;	
end
fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);

%diabetes, N=442, D=64
%this second version of the diabetes dataset has 64 dimensions rather than
%10
total_train_time=0;
total_test_time=0;
for i=1:1
	fprintf('%d,',i);
	tic;
	model=regRF_train(diabetes.x2,diabetes.y,1000);
	total_train_time=total_train_time+toc;
	tic;
	y_hat =regRF_predict(diabetes.x2,model);
	total_test_time=total_test_time+toc;	
end
fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);
