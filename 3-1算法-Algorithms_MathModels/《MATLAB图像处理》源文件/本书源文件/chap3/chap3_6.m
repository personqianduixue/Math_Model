close all;									%关闭当前所有图形窗口
clear all;									%清空工作空间变量
clc;										%清屏
[X,map]=imread('forest.tif');%像信息
I = ind2gray(X,map);							%再将索引图像转换为灰度图像
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);				%修改图形背景颜色的设置
figure,imshow(X,map);					%将索引图像显示
figure,imshow(I);						%将灰度图像显示

