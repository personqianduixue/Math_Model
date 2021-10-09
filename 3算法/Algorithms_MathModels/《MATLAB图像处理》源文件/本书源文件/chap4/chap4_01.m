close all;                            %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
gamma=0.5;                            %设定调整线性度取值
I=imread('peppers.png');			  %读入要处理的图像，并赋值给I
R=I;                                  %将图像数据赋值给R
R (:,:,2)=0;                          %将原图像变成单色图像，保留红色
R(:,:,3)=0;
R1=imadjust(R,[0.5 0.8],[0 1],gamma); %利用函数imadjust调整R的灰度，结果返回R1
G=I;								  %将图像数据赋值给G
G(:,:,1)=0;							  %将原图像变成单色图像，保留绿色
G(:,:,3)=0;
G1=imadjust(G,[0 0.3],[0 1],gamma);	  %利用函数imadjust调整G的灰度，结果返回G1
B=I;								  %将图像数据赋值给B
B(:,:,1)=0;							  %将原图像变成单色图像，保留蓝色
B(:,:,2)=0;
B1=imadjust(B,[0 0.3],[0 1],gamma);	  %利用函数imadjust调整B的灰度，结果返回B1
I1=R1+G1+B1;                          %求变换后的RGB图像  
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1)
subplot(121),imshow(R);%绘制R、R1、G、G1、B、B1图像，观察线性灰度变换结果
subplot(122),imshow(R1); 
figure(2);
subplot(121),imshow(G);
subplot(122),imshow(G1);
figure(3);
subplot(121),imshow(B);
subplot(122),imshow(B1);
figure(4);
subplot(121),imshow(I);
subplot(122),imshow(I1);