%% 第二张数字高程图的处理
clc;clear;close all;tic;
z=imread('附件4 距月面100m处的数字高程图.tif');
%z=double(z);
% x=1:length(K);
% y=x;
% [X,Y]=meshgrid(x,y);
% mesh(X,Y,double(K));
% colormap(gray);
% colorbar;
% imshow(K);
%% 划分区域
temp=z(51:950,51:950);%转化为可均分的900X900九宫格矩阵
for i=1:9
    switch i
         case   {1,2,3}
     G{i}=temp(1:300,1+(i-1)*300:i*300);
         case   {4,5,6}
     G{i}=temp(301:600,1+(i-4)*300:(i-3)*300);
         case   {7,8,9}
     G{i}=temp(601:end,1+(i-7)*300:(i-6)*300);
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
result=[MEAN;JICHA;STD;XD];

%% STD XD 的归一化
m1=max(STD);
m2=min(STD);

m3=max(XD);
m4=min(XD);

STD2=(STD-m2)/(m1-m2);
XD2=(XD-m4)/(m3-m4);
RESULT=[MEAN;JICHA;STD2;XD2;STD2+XD2];

%% 等高线图的绘制
% figure;
% %z=double(z);
% x=1:length(z);
% y=x;
% [X2,Y2]=meshgrid(x,y);
% subplot(121);
% contour(X2,Y2,z);
% title('距月面100m处的等高线图','FontSize',14);
% colormap(gray);
% z1=G{1};
% x=1:length(z1);
% y=x;
% [X2,Y2]=meshgrid(x,y);
% subplot(122);
% contour(X2,Y2,z1);
% colormap(gray);colorbar;
% title('1号区域等高线图','FontSize',14);
toc;