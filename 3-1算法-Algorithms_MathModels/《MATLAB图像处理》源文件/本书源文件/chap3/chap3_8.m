close all;									%关闭当前所有图形窗口
clear all;									%清空工作空间变量
clc;										%清屏
I=imread('rice.png');							%读取图像信息
BW1=im2bw(I,0.4);							%将灰度图像转换为二值图像，level值为0.4			
BW2=im2bw(I,0.6);							%将灰度图像转换为二值图像，level值为0.6
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);				%修改图形背景颜色的设置
figure;
subplot(131),imshow(I);					%显示level=0.4转换后的二值图像
subplot(132),imshow(BW1);					%显示level=0.5转换后的二值图像
subplot(133),imshow(BW2);					%显示level=0.6转换后的二值图像
