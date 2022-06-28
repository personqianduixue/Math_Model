close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load gatlin2;%装载并显示原始图像
init=2055615866;%生成含噪图象并显示
randn('seed',init)
XX=X+2*randn(size(X));
[c,l]=wavedec2(XX,2,'sym4');%对图像进行消噪处理,用sym4小波函数对x进行两层分解
a2=wrcoef2('a',c,l,'sym4',2); %重构第二层图像的近似系数
n=[1,2];%设置尺度向量
p=[10.28,24.08];%设置阈值向量
nc=wthcoef2('t',c,l,n,p,'s');%对高频小波系数进行阈值处理
mc=wthcoef2('t',nc,l,n,p,'s');%再次对高频小波系数进行阈值处理
X2=waverec2(mc,l,'sym4');%%图像的二维小波重构
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                                % 显示原图像及处理以后结果
colormap(map)
subplot(131),image(XX),axis square; 
subplot(132),image(a2),axis square;
subplot(133),image(X2),axis square;        
Ps=sum(sum((X-mean(mean(X))).^2));%计算信噪比
Pn=sum(sum((a2-X).^2));
disp('利用小波2层分解去噪的信噪比')
snr1=10*log10(Ps/Pn)   
disp('利用小波阈值去噪的信噪比')
Pn1=sum(sum((X2-X).^2));
snr2=10*log10(Ps/Pn1)