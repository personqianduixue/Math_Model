function [train_ica,test_ica] = fasticaForSVM(train,test)
% fasticaForSVM

%%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto BNU
%last modified 2010.01.17
%Super Moderator @ www.ilovematlab.cn

%% Èô×ªÔØÇë×¢Ã÷£º
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2009. 
% Software available at http://www.ilovematlab.cn
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm

%%
[mtrain,ntrain] = size(train);
[mtest,ntest] = size(test);
dataset = [train;test];

[dataset_ica,A,W] = fastica(dataset');
dataset_ica = dataset_ica';

train_ica = dataset_ica(1:mtrain,:);
test_ica = dataset_ica( (mtrain+1):(mtrain+mtest),: );
