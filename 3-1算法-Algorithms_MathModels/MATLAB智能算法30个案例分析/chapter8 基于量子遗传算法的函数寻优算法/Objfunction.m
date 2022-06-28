function [Y,X]=Objfunction(x,lenchrom)
%% 目标函数
% 输入     x：二进制编码
%   lenchrom：各变量的二进制位数
% 输出     Y：目标值
%          X：十进制数
bound=[-3.0 12.1;4.1 5.8];   % 函数自变量的范围
%% 将binary数组转化成十进制数组
X=bin2decFun(x,lenchrom,bound);
%% 计算适应度-函数值
Y=sin(4*pi*X(1))*X(1)+sin(20*pi*X(2))*X(2);