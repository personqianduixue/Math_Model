close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load flujet;           %装载并显示原始图像
init=2055615866;        %生成含噪声图像并显示
XX=X+8*randn(size(X));
n=[1,2];                %设置尺度向量
p=[10.28,24.08];        %设置阈值向量
[c,l]=wavedec2(XX,2,'db2');%用小波函数db2对图像XX进行2层分解
nc=wthcoef2('t',c,l,n,p,'s');%对高频小波系数进行阈值处理
mc=wthcoef2('t',nc,l,n,p,'s');%再次对高频小波系数进行阈值处理
X2=waverec2(mc,l,'db2');%%图像的二维小波重构

[c1,l1]=wavedec2(XX,2,'sym4');%首先用小波函数sym4对图像XX进行2层分解
nc1=wthcoef2('t',c1,l1,n,p,'s');%对高频小波系数进行阈值处理
mc1=wthcoef2('t',nc1,l1,n,p,'s');%再次对高频小波系数进行阈值处理
X3=waverec2(mc1,l1,'sym4');%%图像的二维小波重构
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                                % 显示原图像及处理以后结果
colormap(map)
subplot(121);image(X);axis square;
subplot(122);image(XX);axis square; 
figure
colormap(map)
subplot(121);image(X2);axis square;
subplot(122);image(X3);axis square;
Ps=sum(sum((X-mean(mean(X))).^2));%计算信噪比
Pn=sum(sum((XX-X).^2));
Pn1=sum(sum((X2-X).^2));
Pn2=sum(sum((X3-X).^2));
disp('未处理的含噪声图像信噪比')
snr=10*log10(Ps/Pn)
disp('采用db2进行小波去噪的图像信噪比')
snr1=10*log10(Ps/Pn1)
disp('采用sym4进行小波去噪的图像信噪比')
snr2=10*log10(Ps/Pn2)
