close all;              %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc
A=imread('ipexroundness_04.png');%读入原始图像赋值给A和B
B=imread('ipexroundness_01.png');
C=immultiply(A,B);              %计算A和B的乘法，计算结果返回给C             
A1=im2double(A);                %将A和B转换成双精度类型，存为A1和B1
B1=im2double(B);
C1=immultiply(A1,B1);           %重新计算A1和B1的乘积，结果返回给C1
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1),% 显示原图像A和B
subplot(121),imshow(A),axis on;
subplot(122),imshow(B),axis on;
figure(2),% 显示uint8和double图像数据格式下，乘积C和C1
subplot(121),imshow(C),axis on;;
subplot(122),imshow(C1),axis on;;



