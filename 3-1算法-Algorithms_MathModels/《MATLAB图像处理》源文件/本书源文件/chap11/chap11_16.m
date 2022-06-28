%【例11-16】
close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('number.jpg');                 %读入图像
K=im2bw(I);                           %I转换为二值图像
J=~K;                                %图像取反
EUL=bweuler(J)                       %求图像的欧拉数
set(0,'defaultFigurePosition',[100,100,1000,500]);  
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(131);imshow(I);           %绘出原图
subplot(132);imshow(K);                %二值图
subplot(133);imshow(J);                %取反后的图
