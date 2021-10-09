A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\pears.png');			%读入并显示原始图像
figure(1),imshow(A);	 
HSV=rgb2hsv(A);				                            
figure(2),imshow(HSV);           %显示变换后的结果
