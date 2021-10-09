% by faruto
% Email:faruto@163.com
% 2010.06.21

%% 
clear;
clc;
%% 
load heart_scale.mat

%把标签设为1,0,方便后续处理
heart_scale_label(heart_scale_label>0) = 1;
heart_scale_label(heart_scale_label<0) = 0;

%训练与预测，一定加上参数'-b 1', 用于估计概率输出，而不是估计标签。因为
%plotroc函数的输入参数必须为估计概率
model = svmtrain(heart_scale_label, heart_scale_inst, '-c 0.001 -g 1 -b 1');
[predict_label, accuracy, dec_values] = svmpredict(heart_scale_label, heart_scale_inst,model,'-b 1');

%调整,至于为什么调整，参见plotroc的参数说明
heart_scale_label = [heart_scale_label, 1 - heart_scale_label];
% plotconfusion(heart_scale_label',dec_values');
targets = heart_scale_label';
outputs = dec_values';
[tpr,fpr,thresholds] = roc(targets,outputs);

%画ROC,注意参数的维数,（求转置）
plotroc2009b(targets,outputs);

% plotSVMroc(heart_scale_label,dec_values);
% 
% [X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = ...
% perfcurve(heart_scale_label,dec_values(:,1),'1');
% AUC