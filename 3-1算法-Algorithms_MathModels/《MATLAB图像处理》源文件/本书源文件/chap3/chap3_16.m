close all;                                    %关闭当前所有图形窗口
clear all;                                     %清空工作空间变量
clc;                                         %清屏
I=imread('tire.tif');                        %读取图像信息
H=[1 2 1;0 0 0;-1 -2 -1];                       %设置subol算子
X=filter2(H,I);                               %对灰度图像G进行2次滤波，实现边缘检测
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);				%修改图形背景颜色的设置
figure,
subplot(131),imshow(I);
subplot(132),imshow(X,[]),colorbar();                  %显示图像，并添加颜色条
subplot(133),imshow(X,[]),colorbar('east');