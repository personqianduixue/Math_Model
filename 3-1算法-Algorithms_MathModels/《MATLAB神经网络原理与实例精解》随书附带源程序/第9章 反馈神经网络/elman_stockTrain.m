% elman_stockTrain.m
%% 清理
close all
clear,clc

%% 加载数据
load stock1
%   Name        Size             Bytes  Class     Attributes
% 
%   stock1      1x280             2240  double     

% 归一化处理
mi=min(stock1);
ma=max(stock1);
stock1=(stock1-mi)/(ma-mi);

% 划分训练数据与测试数据：前140个维训练样本，后140个维测试样本
traindata = stock1(1:140);

%% 训练
% 输入
P=[];
for i=1:140-5
    P=[P;traindata(i:i+4)];
end
P=P';

% 期望输出
T=[traindata(6:140)];

% 创建Elman网络
threshold=[0 1;0 1;0 1;0 1;0 1];
% net=newelm(threshold,[0,1],[20,1],{'tansig','purelin'});
net=elmannet;
%  开始训练
% 设置迭代次数
net.trainParam.epochs=1000;
% 初始化
net=init(net); 
net=train(net,P,T);

% 保存训练好的网络
save stock_net net

%% 使用训练数据测试一次
y=sim(net,P);
error=y-T;
mse(error);

fprintf('error= %f\n', error);

T = T*(ma-mi) + mi;
y = y*(ma-mi) + mi;
plot(6:140,T,'b-',6:140,y,'r-');
title('使用原始数据测试');
legend('真实值','测试结果');
