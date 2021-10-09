A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\eight.tif');                           %读取图像
B=imnoise(A,'salt & pepper',0.02);         %添加椒盐噪声
K=medfilt2(B);                             %中值滤波
figure %显示
subplot(121),imshow(B);                  %显示添加椒盐噪声后的图像
subplot(122),imshow(K);                  %显示平滑处理后图像

 