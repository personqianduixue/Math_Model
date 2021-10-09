function Chapter_ModelDecryption
%% Matlab神经网络43个案例分析

% LIBSVM参数实例详解
% by 李洋(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% A Little Clean Work
clear;
clc;
close all;
format compact;
%%
% 首先载入数据
load heart_scale;
data = heart_scale_inst;
label = heart_scale_label;
% 建立分类模型
model = svmtrain(label,data,'-s 0 -t 2 -c 1.2 -g 2.8');
% 利用建立的模型看其在训练集合上的分类效果
[PredictLabel,accuracy] = svmpredict(label,data,model);
accuracy

%% 分类模型model解密
model
Parameters = model.Parameters
Label = model.Label
nr_class = model.nr_class
totalSV = model.totalSV
nSV = model.nSV 

%%
plable = zeros(270,1);
for i = 1:270
    x = data(i,:);
    plabel(i,1) = DecisionFunction(x,model);
end

%% 验证自己通过决策函数预测的标签和svmpredict给出的标签相同
flag = sum(plabel == PredictLabel)

%% DecisionFunction
function plabel = DecisionFunction(x,model)

gamma = model.Parameters(4);
RBF = @(u,v)( exp(-gamma.*sum( (u-v).^2) ) );

len = length(model.sv_coef);
y = 0;

for i = 1:len
    u = model.SVs(i,:);
    y = y + model.sv_coef(i)*RBF(u,x);
end
b = -model.rho;
y = y + b;

if y >= 0
    plabel = 1;
else
    plabel = -1;
end