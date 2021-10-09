close all;                                    %关闭当前所有图形窗口
clear all;                                     %清空工作空间变量
clc;                                         %清屏
I=imread('lena.bmp');                         %读取图像信息
set(0,'defaultFigurePosition',[100,100,1000,500]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
figure,
subplot(221),imshow(I);
subplot(222),image(I);
subplot(223),image([50,200],[50,300],I);
subplot(224),imagesc(I,[60,150]);
