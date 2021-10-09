%% SVC_test

%%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto
%last modified 2011.06.08

%% Èô×ªÔØÇë×¢Ã÷£º
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2011. 
% Software available at http://www.matlabsky.com
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm

%%
tic;
close all;
clear;
clc;
format compact;
%%

% load wine_test;
% train_label = train_data_labels;
% train_data = train_data;
% test_label = test_data_labels;
% test_data = test_data;
load picdata;
test_data = train_data;
test_label = train_label;
%%
Method_option.plotOriginal = 0;
Method_option.scale = 1;
Method_option.plotScale = 0;
Method_option.pca = 0;
Method_option.type = 1;
%%
[predict_label,accuracy] = SVC(train_label,train_data,test_label,test_data,Method_option);
%%
toc;

