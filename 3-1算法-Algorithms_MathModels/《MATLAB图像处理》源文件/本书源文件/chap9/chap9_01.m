close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
RGB=reshape(ones(64,1)*reshape(jet(64),1,192),[64,64,3]);		%调整颜色条尺寸为正方形
HSV=rgb2hsv(RGB);										%将RGB图像转换为HSV图像
H=HSV(:,:,1);											%提取H矩阵
S=HSV(:,:,2);											%提取S矩阵
V=HSV(:,:,3);											%提取V矩阵
figure(1)
subplot(121), imshow(H)									%显示H图像
subplot(122), imshow(S)									%显示S图像
figure(2)
subplot(121), imshow(V)									%显示V图像
subplot(122), imshow(RGB)								%显示RGB图像
