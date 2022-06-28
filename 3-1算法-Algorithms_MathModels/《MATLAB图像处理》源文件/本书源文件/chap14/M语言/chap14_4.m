A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\round.jpg');           %读入并显示原始图像
B=im2bw(A);                          %转换为二值图像
figure,imshow(B);                 %显示变换后的结果
