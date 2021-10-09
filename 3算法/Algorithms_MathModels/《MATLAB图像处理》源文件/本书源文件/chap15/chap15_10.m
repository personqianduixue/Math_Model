clear all;  						%清除工作空间，关闭图形窗口，清除命令行
close all;
clc;
I=imread('girl1.bmp');
I1=refine_face_detection(I); 			%人脸分割
I1=double(I1);
[m,n]=size(I1);
theta1=0;							%方向
theta2=pi/2;
f = 0.88;							%中心频率
sigma = 2.6;						%方差
Sx = 5;
Sy = 5;							%窗宽度和长度
Gabor1=Gabor_hy(Sx,Sy,f,theta1,sigma);%产生Gabor变换的窗口函数
Gabor2=Gabor_hy(Sx,Sy,f,theta2,sigma);%产生Gabor变换的窗口函数
Regabout1=conv2(I1,double(real(Gabor1)),'same');
Regabout2=conv2(I1,double(real(Gabor2)),'same');
Regabout=(Regabout1+Regabout2)/2;
%% 第一次膨胀
J1 = im2bw(Regabout,0.2);
SE1 = strel('square',2);BW = imdilate(J1,SE1);
[B,L,N] = bwboundaries(BW,'noholes');	%边界跟踪
a = zeros(1,N);
for i1 = 1:N
    a(i1) = length(find(L == i1));
end
a1 = find(a > 300);
for i1 = 1:size(a1,2)
L(find(L == a1(i1))) = 0;
end
L1 = double(uint8(L*255))/255;
a = 0;
BW = I1 .* L1;
%% 第二此膨胀
for i2 = 1:m
    for j2 = 1:n
        if BW(i2,j2) > 0 && BW(i2,j2) < 50
            BW(i2,j2) = 255;
        end
    end
end
BW = uint8(BW);
J2 = im2bw(BW,0.8);
SE1 = strel('rectangle',[2 5]);BW = imdilate(J2,SE1);
[B,L,N] = bwboundaries(BW,'noholes');	%边界跟踪
a = zeros(1,N);
for i1 = 1:N
    a(i1) = length(find(L == i1));
end
a1 = find(a > 300);
for i1 = 1:size(a1,2)
L(find(L == a1(i1))) = 0;
end
L1 = double(uint8(L*255))/255;
a =0;
SE1 = strel('rectangle',[10 10]);BW = imdilate(L1,SE1);
BW = uint8(I1 .* double(BW));
set(0,'defaultFigurePosition',[100,100,1200,450]); %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])                %修改图形背景颜色的设置
figure,
imshow(BW);
