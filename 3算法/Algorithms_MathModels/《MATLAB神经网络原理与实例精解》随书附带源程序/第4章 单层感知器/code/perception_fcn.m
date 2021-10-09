% perception_newp.m
% 清理
clear,clc
close all

% 创建感知器
net=newp([-20,20;-20,20],1);

%定义输入训练向量
P=[ -9,  1, -12, -4,   0, 5;...
   15,  -8,   4,  5,  11, 9];
% 期望输出
T=[0,1,0,0,0,1]

% 训练
net=train(net,P,T);

% 输入训练数据仿真验证
Y=sim(net,P)
