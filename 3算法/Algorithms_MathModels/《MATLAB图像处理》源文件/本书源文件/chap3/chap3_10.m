close all;									%关闭当前所有图形窗口
clear all;									%清空工作空间变量
clc;										%清屏
I=imread('pears.png');						%读取图像信息
BW=im2bw(I,0.5);							%将RGB图像转换为二值图像
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);				%修改图形背景颜色的设置
figure,
subplot(121),imshow(I);						%显示原图像
subplot(122),imshow(BW);					%显示转换后二值图像

