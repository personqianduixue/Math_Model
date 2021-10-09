close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
X=imread('flower.tif');         %读取图像进行 灰度转换
X=rgb2gray(X);
[c,s] = wavedec2(X,2,'db4');    %对图像进行小波2层分解
siz = s(size(s,1),:);           %提取第2层小波分解系数矩阵大小
ca2 = appcoef2(c,s,'db4',2);    %提取第1层小波分解的近似系数
chd2 = detcoef2('h',c,s,2);     %提取第1层小波分解的细节系数水平分量
cvd2 = detcoef2('v',c,s,2);     %提取第1层小波分解的细节系数垂直分量    
cdd2 = detcoef2('d',c,s,2);     %提取第1层小波分解的细节系数对角分量
a2 = upcoef2('a',ca2,'db4',2,siz); %利用函数upcoef2对提取2层小波系数进行重构
hd2 = upcoef2('h',chd2,'db4',2,siz); 
vd2 = upcoef2('v',cvd2,'db4',2,siz);
dd2 = upcoef2('d',cdd2,'db4',2,siz);
A1=a2+hd2+vd2+dd2;
[ca1,ch1,cv1,cd1] = dwt2(X,'db4');    %对图像进行小波单层分解
a1 = upcoef2('a',ca1,'db4',1,siz);   %利用函数upcoef2对提取1层小波分解系数进行重构
hd1 = upcoef2('h',cd1,'db4',1,siz); 
vd1 = upcoef2('v',cv1,'db4',1,siz);
dd1 = upcoef2('d',cd1,'db4',1,siz);
A0=a1+hd1+vd1+dd1;
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                                 %显示相关滤波器
subplot(141);imshow(uint8(a2));
subplot(142);imshow(hd2);
subplot(143);imshow(vd2);
subplot(144);imshow(dd2);
figure
subplot(141);imshow(uint8(a1));
subplot(142);imshow(hd1);
subplot(143);imshow(vd1);
subplot(144);imshow(dd1);
figure
subplot(131);imshow(X);
subplot(132);imshow(uint8(A1));
subplot(133);imshow(uint8(A0));

