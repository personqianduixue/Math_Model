clear all;          %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clc
close all;
A=imread('cameraman.tif');%
B=imread('testpat1.png');
C=imsubtract(A,B);  %进行图像减法
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure,%显示原图像及差异图像
subplot(121),imshow(C);
subplot(122),imshow(255-C);