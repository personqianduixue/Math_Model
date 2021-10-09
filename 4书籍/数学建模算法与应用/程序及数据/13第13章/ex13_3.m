f=imread('Lena.bmp'); %读原图像
f1=imnoise(f,'salt & pepper',0.02); %加椒盐噪声
g=medfilt2(f1); %进行中值滤波
subplot(1,3,1),imshow(f),title('原图像')
subplot(1,3,2),imshow(f1),title('被椒盐噪声污染的图像')
subplot(1,3,3),imshow(g),title('中值滤波图像')
