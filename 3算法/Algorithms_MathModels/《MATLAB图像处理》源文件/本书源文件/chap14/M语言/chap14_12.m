A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\coins.png');                         %读取图像
B=im2bw(A);                                 %转换成二值图像
SE=strel('disk',5);    
C=imopen(B,SE);                             %对图像进行开启操作
figure
subplot(121),imshow(B);                     %显示二值图像        
subplot(122),imshow(C);                     %显示开运算后图像