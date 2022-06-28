close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
I1=imread('lena.bmp');  					%读入图像
I2=I1(:);  								%将原始图像写成一维的数据并设为 I2
I2length=length(I2); 						%计算I2的长度
I3=im2bw(I1,0.5);						%将原图转换为二值图像，阈值为0.5
%以下程序为对原图像进行行程编码，压缩
X=I3(:);  								%令X为新建的二值图像的一维数据组
L=length(X);
j=1;
I4(1)=1;
for z=1:1:(length(X)-1)  					%行程编码程序段
if  X(z)==X(z+1)
I4(j)=I4(j)+1;
else
data(j)=X(z);  							% data(j)代表相应的像素数据
j=j+1;
I4(j)=1;
end
end
data(j)=X(length(X)); 					%最后一个像素数据赋给data
I4length=length(I4);  					%计算行程编码后的所占字节数，记为I4length
CR=I2length/I4length; 					%比较压缩前于压缩后的大小
%下面程序是行程编码解压
l=1;
for m=1:I4length
    for n=1:1:I4(m);
        decode_image1(l)=data(m);
        l=l+1;
    end
end
decode_image=reshape(decode_image1,512,512); %重建二维图像数组 						
figure,
x=1:1:length(X); 
subplot(131),plot(x,X(x));%显示行程编码之前的图像数据
y=1:1:I4length ;          				
subplot(132),plot(y,I4(y));%显示编码后数据信息
u=1:1:length(decode_image1);       			
subplot(133),plot(u,decode_image1(u));%查看解压后的图像数据
subplot(121);imshow(I3);%显示原图的二值图像
subplot(122),imshow(decode_image); 			%显示解压恢复后的图像
disp('压缩比: ')
disp(CR);
disp('原图像数据的长度：')
disp(L);
disp('压缩后图像数据的长度：')
disp(I4length);
disp('解压后图像数据的长度：')
disp(length(decode_image1));
