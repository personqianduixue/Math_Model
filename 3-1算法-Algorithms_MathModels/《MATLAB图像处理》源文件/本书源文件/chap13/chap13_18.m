close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
X1 = imread('girl.bmp');          % 载入原始两幅图像
X2 = imread('lenna.bmp');
FUSmean = wfusimg(X1,X2,'db2',5,'mean','mean');%通过函数wfusing实现两种图像融合
FUSmaxmin = wfusimg(X1,X2,'db2',5,'max','min');
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                 %创建图形显示窗口
subplot(121), imshow(uint8(FUSmean))
subplot(122), imshow(uint8(FUSmaxmin))