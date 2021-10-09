A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\autumn.tif');                       %读取并显示图像
B=imrotate(A,90,'nearest');                   %将图像旋转九十度
figure,imshow(B)        %显示旋转后图像
