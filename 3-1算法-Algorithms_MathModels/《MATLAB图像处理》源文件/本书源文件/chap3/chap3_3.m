close all;									%关闭当前所有图形窗口
clear all;									%清空工作空间变量
clc;										%清屏
RGB = imread('football.jpg');					%读取图像信息
[X1,map1]=rgb2ind(RGB,64);					%将RGB图像转换成索引图像，颜色种数N是64种      
[X2,map2]=rgb2ind(RGB,0.2);					%将RGB图像转换成索引图像，颜色种数N是216种
map3= colorcube(128);						%创建一个指定颜色数目的RGB颜色映射表
X3=rgb2ind(RGB,map3);
set(0,'defaultFigurePosition',[100,100,1000,500]); 	%修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);				%修改图形背景颜色的设置
figure; 
subplot(131),imshow(X1,map1); %显示用最小方差法转换后索引图像
subplot(132),imshow(X2,map2); %显示用均匀量化法转换后索引图像
subplot(133),imshow(X3,map3); %显示用颜色近似法转换后索引图像



