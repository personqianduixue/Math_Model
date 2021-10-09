A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\tire.tif');                                   %读取图像
B=imnoise(A,'salt & pepper');                         %添加椒盐噪声
SE = strel('disk',2);
C= imopen(B,SE);                                    %对图像进行开启操作
D= imclose(C,SE);                                   %对图像进行闭合操作
figure
subplot(131),imshow(B);                             %显示添加椒盐噪声后图像
subplot(132),imshow(C);                             %显示开运算后图像
subplot(133),imshow(D);                             %显示闭运算后图像

