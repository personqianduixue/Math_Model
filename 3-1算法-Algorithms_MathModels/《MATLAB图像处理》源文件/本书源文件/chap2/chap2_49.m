close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
[x,y,z]=peaks;					
figure(1)
subplot(121);
contour(z);					%绘制峰函数的等高线
subplot(122);
contour(z,16);		  			%绘制等高线指定条数
