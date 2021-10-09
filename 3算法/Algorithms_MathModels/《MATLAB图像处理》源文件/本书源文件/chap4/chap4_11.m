close all; 							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc
A=imread('house.jpg');				%读入图像，赋值给A
B=immultiply(A,1.5);					%分别乘以缩放因子1.5和0.5，结果返回给B和C
C=immultiply(A,0.5);
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1),
subplot(1,2,1),imshow(B),axis on;%显示乘以缩放因子以后的图像
subplot(1,2,2),imshow(C),axis on;

