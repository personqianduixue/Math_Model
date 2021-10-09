close all;                                        %关闭当前所有图形窗口
clear all;                                        %清空工作空间变量
clc;                                             %清屏
I1=imread('football.jpg');                           %读取一幅RGB图像
I2=imread('cameraman','tif');                       %读取一幅灰度图像
I3=imread('E:\onion.png');                         %读取非当前路径下的一幅RGB图像
set(0,'defaultFigurePosition',[100,100,1000,500]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
figure,
subplot(1,3,1),imshow(I1);              %显示该RGB图像
subplot(1,3,2),imshow(I2);               %显示该灰度图像
subplot(1,3,3),imshow(I3);               %显示该RGB图像  
