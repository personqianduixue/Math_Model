%【例11-1】颜色矩求法
close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('hua.jpg');                         %I为花的彩色图像，以下是求花的图像的RGB分量均值
R=I(:,:,1);                                  %红色分量
G=I(:,:,2);                                  %绿色分量 
B=I(:,:,3);                                   %蓝色分量 
R=double(R);  G=double(G); B=double(B);     %利用double()函数将变量类型转为double型
Ravg1=mean2(R);                           %红色分量均值
Gavg1=mean2(G);                           %绿色分量均值
Bavg1=mean2(B);                            %蓝色分量均值 
Rstd1=std(std(R));			                %红色分量的方差
Gstd1= std(std(G));		             	       %绿色分量的方差
Bstd1=std(std(B));			                 %蓝色分量的方差
J=imread('yezi.jpg');                           %J为叶子的彩色图像以下是求叶子的图像的RGB分量均值
R=J(:,:,1);                                    %红色分量
G=J(:,:,2);                                    %绿色分量 
B=J(:,:,3);                                     %蓝色分量 
R=double(R);  G=double(G); B=double(B);       %利用double()函数将变量类型转为double型
Ravg2=mean2(R);                             %红色分量均值
Gavg2=mean2(G);                             %绿色分量均值
Bavg2=mean2(B);                              %蓝色分量均值 
Rstd2=std(std(R));			                  %红色分量的方差
Gstd2= std(std(G));			                  %绿色分量的方差
Bstd2=std(std(B));			                  %蓝色分量的方差
set(0,'defaultFigurePosition',[100,100,1000,500]);  %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       
K=imread('flower1.jpg');figure;subplot(131),imshow(K); %显示原图像  
subplot(132),imshow(I);                         %显示花的图像  
subplot(133),imshow(J);                         %显示叶子的图像




