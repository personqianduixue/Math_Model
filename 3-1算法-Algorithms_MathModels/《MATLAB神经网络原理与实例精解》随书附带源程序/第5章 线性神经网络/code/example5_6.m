% example5_6.m
rand('seed',2)			% 设定随机数种子
a=rand(3,4)			% 3*4矩阵

% a =
% 
%     0.0258    0.1901    0.2319    0.0673
%     0.9210    0.8673    0.1562    0.3843
%     0.7008    0.4185    0.7385    0.9427

mse(a)				% 计算均方误差

% ans =
% 
%     0.3307

b=a(:);				% 把矩阵a整理成向量
sum(b.^2)/length(b)		% 手工计算均方误差

% ans =
% 
% 0.3307
mse(b)				% 对向量b计算均方误差

% ans =
% 
%     0.3307
web -broswer http://www.ilovematlab.cn/forum-222-1.html