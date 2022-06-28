% bp_imageCompress.m
% 基于BP神经网络的图像压缩

%% 清理
clc
clear all
rng(0)

%% 压缩率控制
K=4;
N=2;
row=256;
col=256;

%% 数据输入
I=imread('d:\lena.bmp');

% 统一将形状转为row*col
I=imresize(I,[row,col]);

%% 图像块划分，形成K^2*N矩阵
P=block_divide(I,K);

%% 归一化
P=double(P)/255;

%% 建立BP神经网络
net=feedforwardnet(N,'trainlm');
T=P;
net.trainParam.goal=0.001;
net.trainParam.epochs=500;
tic
net=train(net,P,T);
toc

%% 保存结果
com.lw=net.lw{2};
com.b=net.b{2};
[~,len]=size(P); % 训练样本的个数
com.d=zeros(N,len);
for i=1:len
    com.d(:,i)=tansig(net.iw{1}*P(:,i)+net.b{1});
end
minlw= min(com.lw(:));
maxlw= max(com.lw(:));
com.lw=(com.lw-minlw)/(maxlw-minlw);
minb= min(com.b(:));
maxb= max(com.b(:));
com.b=(com.b-minb)/(maxb-minb);
maxd=max(com.d(:));
mind=min(com.d(:));
com.d=(com.d-mind)/(maxd-mind);

com.lw=uint8(com.lw*63);
com.b=uint8(com.b*63);
com.d=uint8(com.d*63);

save comp com minlw maxlw minb maxb maxd mind
web -broswer http://www.ilovematlab.cn/forum-222-1.html