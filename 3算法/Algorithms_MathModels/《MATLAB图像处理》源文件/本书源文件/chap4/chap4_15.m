close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('cameraman.tif'); %读取图像
J=imread('rice.png');
K1=imlincomb(1.0,I,1.0,J); %两个图像叠加
K2=imlincomb(1.0,I,-1.0,J,'double'); %两个图像相减
K3=imlincomb(2,I); %图像的乘法
K4=imlincomb(0.5,I);%图像的除法
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1),            %显示结果
subplot(121),imshow(K1);
subplot(122),imshow(K2);
figure,
subplot(121),imshow(K3);
subplot(122),imshow(K4);