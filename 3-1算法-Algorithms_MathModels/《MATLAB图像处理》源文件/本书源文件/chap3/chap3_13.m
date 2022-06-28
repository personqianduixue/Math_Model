clear all;
close all;
clc;
[X,map]=imread('beach.gif',2);
[X1,map1]=imread('beach.gif',12);
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);				%修改图形背景颜色的设置
figure,
subplot(121),imshow(X,map);
subplot(122),imshow(X1,map1);
I1=imread('pillsetc.png','BackgroundColor',[1 0 0]);
I2=imread('rice.png','BackgroundColor',1);
I3=imread('forest.tif','BackgroundColor',64);
