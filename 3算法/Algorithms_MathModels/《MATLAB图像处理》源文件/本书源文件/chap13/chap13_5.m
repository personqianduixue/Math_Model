close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
X=imread('girl.bmp');      %读取图像
X=rgb2gray(X);             %转换图像数据类型
[ca1,chd1,cvd1,cdd1] = dwt2(X,'bior3.7');
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])  
figure                             %显示小波变换各个分量
subplot(141); 
imshow(uint8(ca1));
subplot(1,4,2); 
imshow(chd1);
subplot(1,4,3); 
imshow(cvd1);
subplot(1,4,4); 
imshow(cdd1);                      %显示原图和小波变换分量组合图像
figure
subplot(121),imshow(X);          
subplot(122),imshow([ca1,chd1;cvd1,cdd1]);