% example4_6_2.m
%% 清理
clear,clc
close all

%% adapt用于线性网络

% 创建线性网络
net=newlin([-1,1],1,[0,1],0.5);

% 定义训练向量1
P1={-1,0,1,0,1,1,-1,0,-1,1,0,1};
T1={-1,-1,1,1,1,2,0,-1,-1,0,1,1};
% 进行调整
[net,y,ee,pf] = adapt(net,P1,T1);
ma=mae(ee)

% 定义训练向量2
P2={1,-1,-1,1,1,-1,0,0,0,1,-1,-1};
T2={2,0,-2,0,2,0,-1,0,0,1,0,-1};
% 调整网络
[net,y,ee,pf] = adapt(net,P2,T2,pf);
ma=mae(ee)

% 用全部数据训练网络
P3=[P1,P2];
T3=[T1,T2];
net.adaptParam.passes=100;
[net,y,ee,pf]=adapt(net,P3,T3,pf);
ma=mse(ee)
web -broswer http://www.ilovematlab.cn/forum-222-1.html