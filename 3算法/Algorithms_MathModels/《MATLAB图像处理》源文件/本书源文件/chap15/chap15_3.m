clear all;  			%清除工作空间，关闭图形窗口，清除命令行
close all;
clc;
N=64;				    %定义量化值N
m=15;
L=2.0;
[x,h]=RLfilter(N,L)
x1=x(N-m:N+m);
h1=h(N-m:N+m);
set(0,'defaultFigurePosition',[100,100,1200,450]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure,                                              
subplot(121),
plot(x,h),axis tight,grid on  %显示波形
subplot(122),
plot(x1,h1),axis tight,grid on %显示波形
