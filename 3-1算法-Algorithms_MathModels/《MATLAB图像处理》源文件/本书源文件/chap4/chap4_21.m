close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
[X,map]=imread('trees.tif');                %读入图像
J1=imresize(X, 0.25);                        %设置缩放比例，实现缩放图像并显示
J2=imresize(X, 3.5);
J3=imresize(X, [64 40]);                   %设置缩放后图像行列，实现缩放图像并显示 
J4=imresize(X, [64 NaN]);
J5=imresize(X, 1.6, 'bilinear');          %设置图像插值方法，实现缩放图像并显示   
J6=imresize(X, 1.6, 'triangle');
[J7, newmap]=imresize(X,'Antialiasing',true,'Method','nearest',...
                      'Colormap','original','Scale', 0.15);%设置图像多个参数，实现缩放图像并显示
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1)                                         %显示各种缩放效果图
subplot(121),imshow(J1);
subplot(122),imshow(J2);
figure(2)
subplot(121),imshow(J3);
subplot(122),imshow(J4);
figure(3)
subplot(121),imshow(J5);
subplot(122),imshow(J6);
figure(4),
subplot(121),imshow(X); 
subplot(122),imshow(J7);
