close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('office_1.jpg');				%读入图像office_1和office_2，并赋值
J=imread('office_2.jpg');
Ip=imdivide(J,I);					%两幅图像相除
K=imdivide(J,0.5);					%图像跟一个常数相除
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1);							%依次显示四幅图像
subplot(121); imshow(I);
subplot(122); imshow(J);
figure(2)
subplot(121); imshow(Ip);
subplot(122); imshow(K);
 