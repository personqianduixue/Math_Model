A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\fuwa.jpg ');                %读入并显示图像
B=fspecial('Sobel');                        %用Sobel算子进行边缘锐化
fspecial('Sobel');
B=B';                                       %Sobel垂直模板
C=filter2(B,A);
figure,imshow(C);                        %显示图像
