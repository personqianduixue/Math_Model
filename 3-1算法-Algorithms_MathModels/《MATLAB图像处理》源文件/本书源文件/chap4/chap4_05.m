close all;%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('flower.tif');%读入flower图像
J=imadd(I,30);         %每个像素值增加30
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
subplot(121),imshow(I); %显示原图像和加常数后的图像
subplot(122),imshow(J);
