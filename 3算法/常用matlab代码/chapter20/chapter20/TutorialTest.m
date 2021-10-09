%% TutorialTest

%% Matlab神经网络43个案例分析

% LIBSVM-FarutoUltimate工具箱及GUI版本介绍与使用
% by 李洋(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% 若转载请注明：
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
%% test for scaleForSVM
train_data = [1 12;3 4;7 8]
test_data = [9 10;6 2]

[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1)

%% test for pcaForSVM
load wine_test
whos train_data
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1);
[train_pca,test_pca] = pcaForSVM(train_scale,test_scale,95);
whos train_pca

%% test for SVMcgForClass
load wine_test
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1);
[bestacc,bestc,bestg]=SVMcgForClass(train_data_labels,train_scale,-10,10,-10,10,5,0.5,0.5,4.5)

%% test for psoSVMcgForClass
load wine_test
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1);

    pso_option.c1 = 1.5;
    pso_option.c2 = 1.7;
    pso_option.maxgen = 100;
    pso_option.sizepop = 20;
    pso_option.k = 0.6;
    pso_option.wV = 1;
    pso_option.wP = 1;
    pso_option.v = 5;
    pso_option.popcmax = 100;
    pso_option.popcmin = 0.1;
    pso_option.popgmax = 100;
    pso_option.popgmin = 0.1;
    
[bestacc,bestc,bestg]=psoSVMcgForClass(train_data_labels,train_scale,pso_option)
%% test for gaSVMcgForClass
load wine_test
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1);
    ga_option.maxgen = 100;
    ga_option.sizepop = 20;
    ga_option.cbound = [0,100];
    ga_option.gbound = [0,100];
    ga_option.v = 10;
    ga_option.ggap = 0.9;
[bestacc,bestc,bestg]=gaSVMcgForClass(train_data_labels,train_scale,ga_option)
%% test for svmplot
load fisheriris;
data = [meas(:,1), meas(:,2)];
groups = ismember(species,'setosa');
[train, test] = crossvalind('holdOut',groups);
dataset = data(train,:);
labels = double(groups(train));
model = svmtrain(labels,dataset,'-c 2 -g 0.1');
svmplot(labels,dataset,model);
%% test for SVC.m
load wine_test;
train_label = train_data_labels;
train_data = train_data;
test_label = test_data_labels;
test_data = test_data;

Method_option.plotOriginal = 0;
Method_option.scale = 1;
Method_option.plotScale = 0;
Method_option.pca = 1;
Method_option.type = 1;

[predict_label,accuracy] = SVC(train_label,train_data,test_label,test_data,Method_option);
%% test for SVR.m
load x123;
train_y = x1(1:17);
train_x = [1:17]';
test_y = x1(18:end,:);
test_x = [18:20]';

Method_option.plotOriginal = 0;
Method_option.xscale = 1;
Method_option.yscale = 1;
Method_option.plotScale = 0;
Method_option.pca = 0;
Method_option.type = 5;

[predict_Y,mse,r] = SVR(train_y,train_x,test_y,test_x,Method_option);
%% test for VF.m
load wine_test
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1);
model = svmtrain(train_data_labels,train_scale,'-c 2 -g 0.1');
[pre,acc] = svmpredict(train_data_labels,train_scale,model);
[score,str] = VF(train_data_labels,pre,1)
[score,str] = VF(train_data_labels,pre,2)
[score,str] = VF(train_data_labels,pre,3)
[score,str] = VF(train_data_labels,pre,4)
[score,str] = VF(train_data_labels,pre,5)
%% test for ClassResult.m
load heart_scale.mat;
data = heart_scale_inst;
label = heart_scale_label;
model = svmtrain(label,data);
type = 1;
CR = ClassResult(label, data, model, type)
%% test for plotSVMroc
load wine_test
[train_data,test_data] = scaleForSVM(train_data,test_data,0,1); 
model = svmtrain(train_data_labels,train_data,'-c 0.01 -g 0.01 -b 1');
[pre,acc,dec] = svmpredict(train_data_labels,train_data,model,'-b 1');
plotSVMroc(train_data_labels,dec,3)
%%
toc;


