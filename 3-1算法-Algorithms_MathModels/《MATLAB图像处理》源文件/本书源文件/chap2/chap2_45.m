close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
x=0:0.01:10;
y1=sin(2.*x);
y2=2.*sin(x);
figure(1);								%打开一个图形窗口
subplot(121);plot(y1);					%将窗口分割成1×2两个区域，分别绘制y1和y2
subplot(122);plot(y2);
