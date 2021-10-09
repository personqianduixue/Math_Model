close all;                          %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
RGB=imread('eight.tif');            %读入eight图像，赋值给RGB
A=imnoise(RGB,'gaussian',0,0.05);    %加入高斯白噪声
I=A;                                %将A赋值给I
M=3;                                %设置叠叠加次数M
I=im2double(I);                     %将I数据类型转换成双精度
RGB=im2double(RGB);
for i=1:M
   I=imadd(I,RGB);                  %对用原图像与带噪声图像进行多次叠加，结果返回给I
end
avg_A=I/(M+1);                      %求叠加的平均图像 
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
subplot(121); imshow(A);   %显示加入椒盐噪声后的图像
subplot(122); imshow(avg_A);    %显示加入乘性噪声后的图像
