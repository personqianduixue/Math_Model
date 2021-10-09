f=imread('tu2.bmp'); %读取原图像
h1=fspecial('laplacian',0); %式（13.3）的滤波器，等价于式（13.5）中参数为0
g1=f-imfilter(f,h1); %中心为-4，c=-1,即从原图像中减去拉普拉斯算子处理的结果
h2=[1 1 1; 1 -8 1; 1 1 1]; %式（13.4）的滤波器
g2=f-imfilter(f,h2); %中心为-8，c=-1
subplot(1,3,1),imshow(f) %显示原图像
subplot(1,3,2),imshow(g1) %显示滤波器(13.3)修复的图像
subplot(1,3,3),imshow(g2) %显示滤波器(13.4)修复的图像
