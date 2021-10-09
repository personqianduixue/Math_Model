% and_hand.m
%% 清理
close all
clear,clc

%% 定义变量
P=[0,0,1,1;0,1,0,1]			% 输入向量
P=[ones(1,4);P]				% 包含偏置的输入向量
d=[0,0,0,1]				% 期望输出向量

% 初始化
w=[0,0,0]				% 权值向量初始化为零向量
lr=maxlinlr(P)				% 根据输入矩阵求解最大学习率
MAX=200;				% 最大迭代次数，根据经验确定

%% 循环迭代
for i=1:MAX...
    fprintf('第%d次迭代\n', i);
    v=w*P;				% 求出输出
    y=v;
    disp('线性网络的二值输出：');
    yy=y>=0.5				% 将模拟输出转化为二值输出，以0.5为阈值
    e=d-y;
    m(i)=mse(e);			% 均方误差
    fprintf('均方误差： %f\n',m(i));
    dw=lr*e*P';				% 权值向量的调整量
    fprintf('权值向量：\n');
    w=w+dw				% 调整权值向量
end

%% 显示
plot([0,0,1],[0,1,0],'o');hold on;
plot(1,1,'d');
x=-2:.2:2;
y=1.5-x;
plot(x,y)
axis([-0.5,2,-0.5,2])
xlabel('x');ylabel('ylabel');
title('线性神经网络用于求解与逻辑')
legend('0','1','分类面');

