close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
[A,map]=imread('peppers.png');  %读入图像
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
[I2,rect]=imcrop(A);              %进行图像剪切
subplot(121),imshow(A); %显示原图像
rectangle('Position',rect,'LineWidth',2,'EdgeColor','r') %显示图像剪切区域
subplot(122),imshow(I2);   %显示剪切的图像             
