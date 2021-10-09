close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
J=imread('rice.png');% 读取灰度图像，赋值给J
J1=im2bw(J);%将灰度图像转换成二值图像，赋值给J1
J2=imcomplement(J);%求灰度图像的补，赋值给J2
J3=imcomplement(J1);%求二值图像的补，赋值给J3
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])         %修改图形背景颜色的设置
figure,                              %显示运算结果
subplot(131),imshow(J1)             %显示灰度图像及其补图像
subplot(132),imshow(J2)         %显示二值图像及其补图像
subplot(133),imshow(J3) 