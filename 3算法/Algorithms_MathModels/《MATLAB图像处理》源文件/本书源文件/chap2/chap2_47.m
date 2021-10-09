close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
y=randn(1000,1);				%建立正态分布的向量
figure;
subplot(121);hist(y);				%采用hist绘制默认直方图
subplot(122);hist(y,20)			%采用hist绘制指定直方图
