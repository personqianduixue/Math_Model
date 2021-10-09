close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
A=imread('office_2.jpg');                   %读入图像
J1=imrotate(A, 30);                         %设置旋转角度，实现旋转并显示
J2=imrotate(A, -30);
J3=imrotate(A,30,'bicubic','crop');        %设置输出图像大小，实现旋转图像并显示 
J4=imrotate(A,30, 'bicubic','loose'); 
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1)                                  %显示旋转处理结果
subplot(121),imshow(J1);
subplot(122),imshow(J2);  
figure(2)
subplot(121),imshow(J3);
subplot(122),imshow(J4);
