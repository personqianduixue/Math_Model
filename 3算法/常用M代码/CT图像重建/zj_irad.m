clc;
clear all;
close all;
N = 256; %图像大小
I = phantom(N); %shepp-logan头模型
theta = 0:1:179; %投影角度
P = radon(I,theta); %生成投影数据
rc = iradon(P,theta,'linear','None');%直接反投影重建
figure;%显示图像
imshow(I),title('原始图像');
figure;
imshow(rc,[]),title('直接反投影重建图像');
