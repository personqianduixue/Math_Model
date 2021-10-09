% pnn_test.m
%% 清理
close all
clear,clc

%% 定义数据
rng(2);
a=rand(14,2)*10;					% 训练数据点
p=ceil(a)';

disp('正确类别：');
tc=[3,1,1,2,1,3,2,3,2,3,3,2,2,3];		% 类别
disp(tc);

%% 用训练数据测试
y=pnn_net(p,tc,p,1);
disp('测试结果：');
disp(y);

