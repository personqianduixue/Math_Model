% comment_example.m
%% 
clear,close all;
clc

%% 打开文件
fid=fopen('data.txt','rb');

%% 读取内容
data=fread(fid, 10, 'uint8');    % 读取10个数据
d=data.^2;

%{
plot(data,d);
title('散点图');
xlabel('x');
ylabel('y');
%}
%% 关闭文件
fclose(fid);