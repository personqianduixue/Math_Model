close all;                  			%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('trees.tif'); 					%输入图像
J1=transp(I);						%对原图像的转置
I1=imread('lenna.bmp'); 				%输入图像
J2=transp(I1);						%对原图像的转置
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure,
subplot(1,2,1),imshow(J1);%绘制移动后图像
subplot(1,2,2),imshow(J2);%绘制移动后图像
