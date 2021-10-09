close all                                         %关闭当前所有图形窗口
clear all;                                         %清空工作空间变量
clc                                              %清屏
I = imread('cameraman.tif')                         %读取灰度图像信息                        
[X,map]=gray2ind(I,8);                          %实现灰度图像向索引图像的转换,N取8
set(0,'defaultFigurePosition',[100,100,1000,500]);  %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);               %修改图形背景颜色的设置
figure,imshow(I);              %显示原灰度图像
figure, imshow(X, map);       %显示N=8转换后索引图像



