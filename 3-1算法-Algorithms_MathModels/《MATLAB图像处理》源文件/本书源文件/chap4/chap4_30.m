close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I=imread('pout.tif');           %输入原图像
BW1=roicolor(I,55,100);                   %基于灰度图像ROI区域选取
c=[87 171 201 165 79 32 87];
r=[133 133 205 259 259 209 133];%定义ROI顶点位置
BW=roipoly(I,c,r); %根据c和r选择ROI区域
I1=roifill(I,BW); %根据生成BW掩膜图像进行区域填充
h=fspecial('motion',20,45); %创建motion滤波器并说明参数
I2=roifilt2(h,I,BW); %进行区域滤波
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure
subplot(121),imshow(BW1); %显示处理结果
subplot(122),imshow(BW); %显示ROI区域
figure
subplot(121),imshow(I1);%显示填充效果
subplot(122),imshow(I2); %显示区域滤波效果
 


