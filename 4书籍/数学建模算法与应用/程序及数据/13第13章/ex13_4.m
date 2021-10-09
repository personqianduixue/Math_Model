clc, clear
cm=imread('cameraman.tif'); %读入Matlab的内置图像文件
[n,m]=size(cm); %计算图像的维数
cf=fft2(cm); %进行傅氏变换
cf=fftshift(cf); %进行中心变换
u=[-floor(m/2):floor((m-1)/2)] %水平频率
v=[-floor(n/2):floor((n-1)/2)] %垂直频率
[uu,vv]=meshgrid(u,v); %频域平面上的网格结点
bl=1./(1+(sqrt(uu.^2+vv.^2)/15).^2); %构造1阶巴特沃兹低通滤波器
cfl=bl.*cf; %逐点相乘，进行低通滤波
cml=real(ifft2(cfl)); %进行逆傅氏变换，并取实部
%cml=ifftshift(cml);
cml=uint8(cml); %必须进行数据格式转换
subplot(1,2,1), imshow(cm)  %显示原图像
subplot(1,2,2), imshow(cml) %显示滤波后的图像
