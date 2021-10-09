%% plotSVMroc_test
% by faruto
% Email:faruto@163.com
% 2010.06.21
%%
clear;
clc;
%%
load wine_test

%%
[train_data,test_data] = scaleForSVM(train_data,test_data,0,1); 
model = svmtrain(train_data_labels,train_data,'-c 0.01 -g 0.01 -b 1');

[pre,acc,dec] = svmpredict(train_data_labels,train_data,model,'-b 1');

%% plotSVMroc
plotSVMroc(train_data_labels,dec,3)
