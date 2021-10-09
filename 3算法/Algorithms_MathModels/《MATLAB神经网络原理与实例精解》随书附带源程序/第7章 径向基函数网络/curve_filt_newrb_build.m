% curve_filt_newrb_build.m
%% 清理
clear all
close all 
clc

%% 定义原始数据
x=-9:8;
y=[129,-32,-118,-138,-125,-97,-55,-23,-4,...
    2,1,-31,-72,-121,-142,-174,-155,-77];

%% 设计RBF网络
P=x;
T=y;
% 计时开始
tic;
% spread = 2
net = newrb(P, T, 0, 2); 
% 记录消耗的时间
time_cost = toc;

% 保存得到的RBF模型net
save curve_filt_newrb_build net
