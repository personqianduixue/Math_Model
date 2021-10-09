close all;                                       %关闭当前所有图形窗口
clear all;                                        %清空工作空间变量
clc;                                             %清屏
I = imread('coins.png');                      %读取图像信息
X = grayslice(I,32);                               %将灰度图像转换为索引图像
set(0,'defaultFigurePosition',[100,100,1000,500]);   %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);                %修改图形背景颜色的设置
figure,imshow(I);              %显示原图像
figure,imshow(X,jet(32));      %jet(M)是相当于colormap，是一个M×3的数组，

