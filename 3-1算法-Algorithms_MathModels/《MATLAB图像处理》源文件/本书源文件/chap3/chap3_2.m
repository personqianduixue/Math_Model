close all;                                      %关闭当前所有图形窗口
clear all;                                      %清空工作空间变量
clc;                                            %清屏
[X,map] = imread('trees.tif');                      %读取原图像信息
newmap = rgb2gray(map);                             %将彩色颜色映射表转换为灰度颜色映射表
set(0,'defaultFigurePosition',[100,100,1000,500]);  %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);               %修改图形背景颜色的设置
figure,imshow(X,map);                   %显示原图像
figure,imshow(X,newmap);                %显示转换后灰度图像
