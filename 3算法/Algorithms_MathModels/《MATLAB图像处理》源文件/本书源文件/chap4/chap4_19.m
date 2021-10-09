close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('lenna.bmp'); %输入图像
a=50;b=50;%设置平移坐标
J1=move1(I,a,b);%移动原图像
a=-50;b=50;%设置平移坐标
J2=move1(I,a,b);%移动原图像
a=50;b=-50;%设置平移坐标
J3=move1(I,a,b);%移动原图像
a=-50;b=-50;%设置平移坐标
J4=move1(I,a,b);%移动原图像
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure,
subplot(1,2,1),imshow(J1),axis on;%绘制移动后图像
subplot(1,2,2),imshow(J2),axis on;%绘制移动后图像
figure,
subplot(1,2,1),imshow(J3),axis on;%绘制移动后图像
subplot(1,2,2),imshow(J4),axis on;%绘制移动后图像