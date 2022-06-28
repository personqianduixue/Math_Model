%例【11-3】
close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('huangguahua.jpg');      %读入要处理的图像，并赋值给I
R=I(:,:,1);                         %图像的R分量
G=I(:,:,2);                         %图像的G分量
B=I(:,:,3);                         %图像的B分量
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1]) 
figure;subplot(121);imshow(I);                            %显示彩色图像
subplot(122);imshow(R);          %R分量灰度图
figure;subplot(121);imshow(G);          %G分量灰度图
subplot(122);imshow(B);          %B分量灰度图
figure;subplot(131);
imhist(I(:,:,1))              %显示红色分辨率下的直方图
subplot(132);imhist(I(:,:,2))              %显示绿色分辨率下的直方图
subplot(133);imhist(I(:,:,3))  %显示蓝色分辨率下的直方图
