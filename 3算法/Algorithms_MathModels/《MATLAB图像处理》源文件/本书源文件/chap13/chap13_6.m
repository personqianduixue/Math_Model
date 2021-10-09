close all;                        %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load woman;                          %读取待处理图像数据.
nbcol = size(map,1);                 %获取颜色映射表的列数
[cA1,cH1,cV1,cD1] = dwt2(X,'db1');   %对图像数据X利用db1小波，进行单层图像分解
sX = size(X);                        %获取原图像大小
A0 = idwt2(cA1,cH1,cV1,cD1,'db4',sX);% 用小波分解的第一层系数进行重构
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
subplot(131),imshow(uint8(X));            %显示处理结果
subplot(132),imshow(uint8(A0));
subplot(133),imshow(uint8(X-A0));

