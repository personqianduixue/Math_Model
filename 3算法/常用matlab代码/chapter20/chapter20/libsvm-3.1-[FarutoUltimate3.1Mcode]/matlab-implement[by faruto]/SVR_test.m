%% SVR_test

%%
% by faruto
% Email:patrick.lee@foxmail.com 
% QQ:516667408 
% http://blog.sina.com.cn/faruto 
% last modified 2011.06.08
% www.matlabsky.com

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
% load dataForcassia_95
% a=1:.5:20;
% b=sin(a).^3-5*cos(a); 
% a = a';
% b = b';
% train_x = a(1:33);
% train_y = b(1:33);
% test_x = a(34:39);
% test_y = b(34:39);
% load exchange;
% train_y = train_ymax;
% train_x = [1:18]';
% load quyingdata;
% train_y = t';
% train_x = p';
% train_y = train_y(1:200,:);
% train_x = train_x(1:200,:);
% test_y = train_y;
% test_x = train_x;
% load x123;
% train_y = x1(1:17);
% train_x = [1:17]';;
% test_y = x1(18:end,:);
% test_x = [18:20]';
load factorsix
load oilsix
train_x=factorsix(1:37,:);
train_y=oilsix(1:37,:);
test_x=factorsix(38:end,:);
test_y=oilsix(38:end,:);
%%
Method_option.plotOriginal = 0;
Method_option.xscale = 1;
Method_option.yscale = 1;
Method_option.plotScale = 0;
Method_option.pca = 0;
Method_option.type = 5;
%%
[predict_Y,mse,r] = SVR(train_y,train_x,test_y,test_x,Method_option);

%%
toc;