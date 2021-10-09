clc, clear
f0=imread('tu3.bmp'); %读入图像
f1=double(f0); %数据转换成double类型
for k=1:3
g(:,:,k)=dct2(f1(:,:,k));  %对R，G，B各个分量分别作离散余弦变换
end
g(abs(g)<0.1)=0;  %把DCT系数小于0.1的变成0
for k=1:3
f2(:,:,k)=idct2(g(:,:,k)); %作逆DCT变换
end
f2=uint8(f2); %把数据转换成uint8格式
imwrite(f2,'tu4.bmp'); %把f2保存成bmp文件
subplot(1,2,1),imshow(f0)
subplot(1,2,2),imshow(f2)
