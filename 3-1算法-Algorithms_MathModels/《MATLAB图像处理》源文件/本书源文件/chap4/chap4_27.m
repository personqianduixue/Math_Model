close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
A = imread('cameraman.tif'); %读取图像
A1=im2double(A);            %数值类型转换
B1 = nlfilter(A1,[4 4],'std2');% 对图像A利用滑动邻域操作函数进行处理
fun = @(x) max(x(:));           % 对图像A利用滑动邻域操作函数进行处理
B2 = nlfilter(A1,[3 3],fun);
B3 = nlfilter(A1,[6 6],fun);
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
subplot(131),imshow(B1); %显示处理后图像
subplot(132),imshow(B2);      
subplot(133),imshow(B3);  