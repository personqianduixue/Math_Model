f=imread('tu1.bmp');  %读原图像
g=imadjust(f,[0; 1],[1; 0]); %进行图像翻转
subplot(1,2,1), imshow(f) %显示原图像
subplot(1,2,2), imshow(g) %显示翻转图像
