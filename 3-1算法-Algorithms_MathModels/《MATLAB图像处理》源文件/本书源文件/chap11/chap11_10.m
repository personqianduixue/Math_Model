%【例11-10】
close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('wall.jpg');                        %读取图像，并赋值给I
I=rgb2gray(I);                              %彩色图像变为灰度图像
[G,gabout] = gaborfilter(I,2,4,16,pi/10);        %调用garborfilter()函数对图像做小波变换
J=fft2(gabout);                             %对滤波后的图像做FFT变换，变换到频域 
A=double(J);
[m,n]=size(A);
B=A;
C=zeros(m,n);
for i=1:m-1
    for j=1:n-1
        B(i,j)=A(i+1,j+1);
        C(i,j)=abs(round(A(i,j)-B(i,j)));
    end
end
h=imhist(mat2gray(C))/(m*n);                  %对矩阵C归一化处理后求其灰度直方图，得到归一化的直方图
mean=0;con=0;ent=0;
for i=1:256                                  %求图像的均值、对比度和熵
    mean=mean+(i*h(i))/256;
    con=con+i*i*h(i);
    if(h(i)>0)
        ent=ent-h(i)*log2(h(i));
    end
end
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(121);imshow(I);
subplot(122);imshow(uint8(gabout));
mean,con,ent
