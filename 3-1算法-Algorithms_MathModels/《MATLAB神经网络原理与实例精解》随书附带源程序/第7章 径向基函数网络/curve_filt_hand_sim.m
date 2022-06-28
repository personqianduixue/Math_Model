%curve_filt_hand_sim.m
%% 清理
clear all
close all
clc
%% 加载模型
load net.mat

%% 测试
%输入
xx=-9:.2:8;

% 计算输入到中心的距离
t = x;
zz=dist(xx',t);

% 计算隐含层的输出
 GG=radbas(zz);

% 计算输出层的输出
Y=GG*w;

%% 绘图
% 原始数据点
plot(x,y,'o');
hold on;
% 拟合的函数曲线
plot(xx,Y','-');
legend('原始数据','拟合数据');
title('用径向基函数拟合曲线');
