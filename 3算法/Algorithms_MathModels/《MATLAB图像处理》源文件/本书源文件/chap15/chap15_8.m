clear all;  			%清除工作空间，关闭图形窗口，清除命令行
close all;
clc;
B=imread('girl2.bmp');					%读入图像
C=imread('boy1.bmp');
BW1=refine_face_detection(B);				%调用函数refine_face_detection进行人脸检测 
BW2=refine_face_detection(C);
set(0,'defaultFigurePosition',[100,100,1200,450]); %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])                 %修改图形背景颜色的设置
figure,
subplot(121),imshow(BW1);                       %显示原图及结果
subplot(122),imshow(BW2);
