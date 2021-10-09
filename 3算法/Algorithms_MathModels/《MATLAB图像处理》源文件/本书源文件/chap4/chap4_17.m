close all;%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clc;
clear all;
I=imread('girl.bmp');           %读入图像，赋值给I和J
J=imread('lenna.bmp');
I1=im2bw(I);                    %转化为二值图像
J1=im2bw(J);
H=~(I1|J1);
G=~(I1&J1);
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1),%显示原图像及相应的二值图像
subplot(121),imshow(I1),axis on;
subplot(122),imshow(J1),axis on;
figure(2), %显示运算以后的图像
subplot(121),imshow(H),axis on;  
subplot(122),imshow(G),axis on;


