% xor_newrbe.m
%% 清理
clear all
close all
clc

%% 输入
% 输入向量
P = [0,0,1,1;0,1,1,0]
%P =
%
%     0     0     1     1
%     0     1     1     0
% 期望输出
T = [0,1,0,1]
%T =
%
%     0     1     0     1
%% 建立网络
net=newrbe(P,T);

% 测试
out=sim(net,P)
%% 绘图
x=0:.2:1;
N=length(x);                         	%  N=6

% X为新的输入向量
X(1,:)=reshape(repmat(x,N,1),N*N,1);
X(2,:)=repmat(x,1,N);
out2=sim(net,X);
% 整理为N*N矩阵
out2=reshape(out2,N,N);
% 绘图
mesh(x,x,out2);
