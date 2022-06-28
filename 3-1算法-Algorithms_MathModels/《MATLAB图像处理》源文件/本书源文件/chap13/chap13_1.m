close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
[X,map]=imread('trees.tif');                %读入图像
R=map(X+1,1);R=reshape(R,size(X));          %获取图像R信息
G=map(X+1,2);G=reshape(G,size(X));          %获取图像G信息
B=map(X+1,3);B=reshape(B,size(X));          %获取图像B信息
Xrgb=0.2990*R+0.5870*G+0.1140*B;            %将RGB混合成单通道
n=64                                        %设置灰度级
X1=round(Xrgb*(n-1))+1;                     %将单通道颜色信息，转换成64灰度级
map2=gray(n);
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure(1),image(X1);
colormap(map2);