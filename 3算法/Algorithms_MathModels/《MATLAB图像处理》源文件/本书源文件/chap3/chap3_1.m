close all;                   %关闭当前所有图形窗口
clear all;                   %清空工作空间变量
clc;                        %清屏
X=imread('football.jpg');      %读取文件格式为.jpg,文件名为football的RGB图像的信息
I=rgb2gray(X);              %将RGB图像转换为灰度图像
set(0,'defaultFigurePosition',[100,100,1000,500]);  %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);               %修改图形背景颜色的设置
subplot(121),imshow(X);            %显示原RGB图像
subplot(122),imshow(I);             %显示转换后灰度图像


