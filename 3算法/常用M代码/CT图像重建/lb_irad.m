clc;
clear all;
close all;
N = 256; %图像大小
I = phantom(N); %shepp-logan头模型
theta = 0:1:179; %投影角度
P = radon(I,theta); %生成投影数据
rc = iradon(P,theta,'linear','None');%直接反投影重建
rec_RL = iradon(P,theta,'linear','Ram-Lak');% 默认滤波器
rec_SL = iradon(P,theta,'linear','Shepp-Logan');
figure;%显示图像
subplot(2,2,1),imshow(I),title('原始图像');
subplot(2,2,2),imshow(rc,[]),title('直接反投影重建图像');
subplot(2,2,3),imshow(rec_RL,[]),title('R-L函数滤波反投影重建图像');
subplot(2,2,4),imshow(rec_SL,[]),title('S-L函数滤波反投影重建图像');

