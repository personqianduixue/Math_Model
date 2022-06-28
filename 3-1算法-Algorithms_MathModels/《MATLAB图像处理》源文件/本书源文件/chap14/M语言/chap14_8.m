A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\kids.tif');   %读取并显示图像
B=imresize(A,0.5,'nearest');  %缩小图像至原始图像的50%
figure(1)
imshow(A);                    %显示原始图像   
figure(2)
imshow(B);                    %显示缩小后的图像
