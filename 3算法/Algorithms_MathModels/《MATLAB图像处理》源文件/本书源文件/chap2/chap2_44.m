close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
x=-20:20;
y=x.^2+2*x+1;							%输入为一维向量
plot(x,y);								
z=magic(4);							%输入为4阶方阵
plot(z);
c=[1+2i,4+3i,7+11i];						%输入为一维复向量
plot(c);				
x1=0:0.01:10;
y1=exp(sin(x1));
y2=sin(2*x1+2.*pi./3);
y3=exp(-0.1.*x1).*sin(6*x1);
plot(x1,y1,x1,y2,x1,y3);					%在同一图形窗口中画出y1，y2和y3曲线
