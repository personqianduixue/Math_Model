close all;              %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
R=imread('peppers.png');%读入原图像，赋值给R
J=rgb2gray(R);          %将彩色图像数据R转换为灰度图像数据J
[M,N]=size(J);          %获得灰度图像数据J的行列数M，N
x=1;y=1;                %定义行索引变量x、列索引变量y    
for x=1:M
    for y=1:N
        if (J(x,y)<=35);     %对灰度图像J进行分段处理，处理后的结果返回给矩阵H
            H(x,y)=J(x,y)*10;
        elseif(J(x,y)>35&J(x,y)<=75);
            H(x,y)=(10/7)*[J(x,y)-5]+50;
        else(J(x,y)>75);
            H(x,y)=(105/180)*[J(x,y)-75]+150;
        end
    end
end
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
subplot(121),imshow(J)%显示处理前后的图像
subplot(122),imshow(H);