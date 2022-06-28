close all;                          %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
RGB=imread('eight.tif');            %读入eight图像，赋值给RGB
M1=3;
[BW1,runningt1]=Denoise(RGB,M1); % M=3叠加
M2=9;
[BW2,runningt2]=Denoise(RGB,M2); % M=9叠加
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
subplot(121); imshow(BW1);   %显示结果
subplot(122); imshow(BW2); 
disp('叠加4次运行时间')
runningt1
disp('叠加10次运行时间')
runningt2
