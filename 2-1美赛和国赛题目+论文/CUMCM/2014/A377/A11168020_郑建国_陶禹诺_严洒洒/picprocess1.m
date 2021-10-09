%% 第一张数字高程图的处理
clc;clear;close all;tic;
z=imread('附件3 距2400m处的数字高程图.tif');
%z=double(z);imshow(z);
% x=1:length(z);y=x;
% [X2,Y2]=meshgrid(x,y);
% %mesh(X2,Y2,double(z));
% %meshc(X2,Y2,double(z));
% [C,h]=contour(X2,Y2,double(z));
% axis([0 2300 0 2300 ]);
% colormap(gray);colorbar;
% toc;
%% 划分区域
temp=z(101:2200,101:2200);%转化为可均分的2100X2100九宫格矩阵
for i=1:9
    switch i
        case  {1,2,3}
     G{i}=temp(1:700,1+(i-1)*700:i*700);
        case  {4,5,6}
     G{i}=temp(701:1400,1+(i-4)*700:(i-3)*700);
        case  {7,8,9}
     G{i}=temp(1401:end,1+(i-7)*700:(i-6)*700);
    end
end
for i=1:9
    b=i;
    a=330+i;
   subplot(a);
   imshow(G{1,i});
end
%% 9个区域的各个统计量计算
MEAN=[];  %高程均值
JICHA=[];   %高程极差
STD=[];      %高程标准差
XD=[];        %区域均值相对于总体均值的“相对高程”
ZT=mean(temp(:));%总体均值
for i=1:9
    TEMP=G{1,i};
    TEMP=double(TEMP(:));
    MEAN=[MEAN,mean(TEMP)];
    MAX=max(TEMP);
    MIN=min(TEMP);
    JICHA=[JICHA,MAX-MIN];
    STD=[STD,std(TEMP)];
    XD=[XD,abs(MEAN(i)-ZT)/ZT];
end
result=[MEAN;JICHA;STD;XD];%未归一化结果
toc;
%% STD XD 的归一化
m1=max(STD);
m2=min(STD);
m3=max(XD);
m4=min(XD);
STD2=(STD-m2)/(m1-m2);
XD2=(XD-m4)/(m3-m4);
%归一化结果。
RESULT=[MEAN;JICHA;STD2;XD2;STD2+XD2];
%% 等高线图的绘制
figure;
z=double(z);
x=1:length(z);
y=x;
[X2,Y2]=meshgrid(x,y);
subplot(121);
[C,h]=contour(X2,Y2,z);
axis([0 2300 0 2300 ]);
title('距月面2400m处的等高线图','FontSize',14);
colormap(gray);
z1=G{5};
x=1:length(z1);
y=x;
[X2,Y2]=meshgrid(x,y);
subplot(122);
contour(X2,Y2,double(z1));
colormap(gray);colorbar;
title('5号区域等高线图','FontSize',14);
toc;





