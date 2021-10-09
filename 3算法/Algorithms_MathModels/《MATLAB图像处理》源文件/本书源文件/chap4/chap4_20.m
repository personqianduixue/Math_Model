close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('cameraman.tif'); %输入图像
J1=mirror(I,1);%原图像的水平镜像
J2=mirror(I,2);%原图像的垂直镜像
J3=mirror(I,3);%原图像的水平垂直镜像
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure,
subplot(1,2,1),imshow(I) ;%绘制原图像
subplot(1,2,2),imshow(J1);%绘制水平镜像后图像
figure,
subplot(1,2,1),imshow(J2);%绘制水平镜像后图像
subplot(1,2,2),imshow(J3);%绘制垂直镜像后图像

