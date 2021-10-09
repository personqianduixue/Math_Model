close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('tire.tif');           %输入图像
I1=im2double(I);                %数值类型转换
f=@(x) min(x);
I2=colfilt(I1,[4 4],'sliding',f);    %按照滑动邻域方式 进行对图像进行最小值邻域操作
m=2;n=2;
f=@(x) ones(m*n,1)*min(x);                    %
I3=colfilt(I1,[m n],'distinct',f);
m=4;n=4;
f=@(x) ones(m*n,1)*min(x);
I4=colfilt(I1,[4 4],'distinct',f);
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure
subplot(131),imshow(I2);
subplot(132),imshow(I3);       %显示原图像和处理后图像
subplot(133),imshow(I4);  