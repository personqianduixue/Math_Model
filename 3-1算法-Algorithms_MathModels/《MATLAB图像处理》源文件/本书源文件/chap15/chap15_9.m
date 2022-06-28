clear all;  			%清除工作空间，关闭图形窗口，清除命令行
close all;
clc;
I=imread('girl1.bmp');
I1=refine_face_detection(I); 			%人脸分割
[m,n]=size(I1);
theta1=0;							%方向
theta2=pi/2;
f = 0.88;							%中心频率
sigma = 2.6;						%方差
Sx = 5;
Sy = 5;							%窗宽度和长度
Gabor1=Gabor_hy(Sx,Sy,f,theta1,sigma);%产生Gabor变换的窗口函数
Gabor2=Gabor_hy(Sx,Sy,f,theta2,sigma);%产生Gabor变换的窗口函数
Regabout1=conv2(I1,double(real(Gabor1)),'same');
Regabout2=conv2(I1,double(real(Gabor2)),'same');
set(0,'defaultFigurePosition',[100,100,1200,450]); %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])                 %修改图形背景颜色的设置
figure,
subplot(131),imshow(I);
subplot(132),imshow(Regabout1);
subplot(133),imshow(Regabout2);
