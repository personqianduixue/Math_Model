%例【11.7】求图像的灰度共生矩阵
close all;							    %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('circuit.tif');              %读入图像circuit.tif
glcm = graycomatrix(I,'Offset',[0 2]);  %图像I的灰度共生矩阵，2表示当前像素与邻居的距离为2，offset为[0 2]表示角度为0为水平方向
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
imshow(I);
glcm
