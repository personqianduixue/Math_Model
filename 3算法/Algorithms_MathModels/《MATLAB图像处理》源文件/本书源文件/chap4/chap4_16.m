close all;%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clc;
clear all;
I=imread('ipexroundness_01.png');%读入图像，赋值给I和J
J=imread('ipexroundness_04.png');
I1=im2bw(I);                    %转化为二值图像
J1=im2bw(J);
K1=I1 & J1;                     %实现图像的逻辑“与”运算
K2=I1 | J1;                     %实现图像的逻辑“或”运算
K3=~I1;                         %实现逻辑“非”运算
K4=xor(I1,J1);                  %实现“异或”运算
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure,                     %显示原图像及相应的二值图像 
subplot(121);imshow(I1),axis on; 
subplot(122);imshow(J1),axis on; 
figure,                      %显示逻辑运算图像
subplot(121);imshow(K1),axis on; 
subplot(122);imshow(K2),axis on;
figure, 
subplot(121);imshow(K3),axis on;
subplot(122);imshow(K4),axis on;
