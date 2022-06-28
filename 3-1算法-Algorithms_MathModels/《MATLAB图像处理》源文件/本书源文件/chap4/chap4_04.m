close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('rice.png');        %读入图像rice，赋值给I
J=imread('cameraman.tif');   %读入图像cameraman，赋值给J
K=imadd(I,J);                %进行两幅图像的加法运算
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
subplot(131),imshow(I); %显示rice，cameraman及相加以后的图像
subplot(132),imshow(J);
subplot(133),imshow(K);
