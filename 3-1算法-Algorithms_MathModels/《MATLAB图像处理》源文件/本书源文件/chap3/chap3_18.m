close all;                    %关闭当前所有图形窗口
clear all;                     %清空工作空间变量
clc;                         %清屏
%I=imread('testpat.png'); 
I=imread('football.jpg');     %读取图像信息
[x,y,z]=sphere;            %创建三个（N+1）×（N+1）的矩阵，使得surf(X,Y,Z)建立一个球体，缺省时N取20
set(0,'defaultFigurePosition',[100,100,1000,400]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
figure,
subplot(121),warp(I);              %显示图像映射到矩形平面
subplot(122),warp(x,y,z,I);              %将二维图像纹理映射三维球体表面
grid;                                   %建立网格

