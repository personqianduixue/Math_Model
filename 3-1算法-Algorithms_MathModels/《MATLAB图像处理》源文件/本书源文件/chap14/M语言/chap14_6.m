A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\liftingbody.png');			%读入并显示原始图像 
B=double(A);
B=256-1-B;
B=uint8(B);		                   %图像数据类型转换                   
figure,imshow(B);               %显示变换后的结果
