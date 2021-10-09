%【例11-9】
close all;			               %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('wall.jpg');               %读入图像
I=rgb2gray(I);                        %图像变为灰度图像
wall=fft2(I);                         %对图像做快速傅里叶变换
s=fftshift(wall);                     %将变换后的图象频谱中心从矩阵的原点移到矩阵的中心
s=abs(s);
[nc,nr]=size(s);
x0=floor(nc/2+1);
y0=floor(nr/2+1);
rmax=floor(min(nc,nr)/2-1);
srad=zeros(1,rmax);
srad(1)=s(x0,y0);
thetha=91:270;                           %thetha取值91-270
for r=2:rmax                             %循环求解纹理频谱能量
    [x,y]=pol2cart(thetha,r);
    x=round(x)'+x0;
    y=round(y)'+y0;
    for j=1:length(x)
        srad(r)=sum(s(sub2ind(size(s),x,y)));
    end
end
[x,y]=pol2cart(thetha,rmax);
x=round(x)'+x0;
y=round(y)'+y0;
sang=zeros(1,length(x));
for th=1:length(x)
    vx=abs(x(th)-x0);
    vy=abs(y(th)-y0);
    if((vx==0)&(vy==0))
        xr=x0;
        yr=y0;
    else
        m=(y(th)-y0)/(x(th)-x0)
        xr=(x0:x(th)).'
        yr=round(y0+m*(xr-x0));
    end
    for j=1:length(xr)
        sang(th)=sum(s(sub2ind(size(s),xr,yr)));
    end
end
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(121);
imshow('wall.jpg');subplot(122);                     %显示原图
imshow(log(abs(wall)),[]);                           %显示频谱图
figure;subplot(121);plot(srad);                      %显示
subplot(122);plot(sang);                             %显示


