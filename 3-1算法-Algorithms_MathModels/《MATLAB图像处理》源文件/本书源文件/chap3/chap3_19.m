close all;                          %关闭当前所有图形窗口
clear all;                           %清空工作空间变量
clc;                               %清屏
load trees;                         %载入图像文件trees.mat，将其中的变量载入workspace中
[X1,map1]=imread('forest.tif');        %读取图像信息
set(0,'defaultFigurePosition',[100,100,1000,500]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
figure,
subplot(1,2,1),subimage(X,map);     %将图像窗口分成1×2个子窗口，在左边子窗口中显示图像X
subplot(1,2,2),subimage(X1,map1);   %在右边子窗口中显示图像X1
