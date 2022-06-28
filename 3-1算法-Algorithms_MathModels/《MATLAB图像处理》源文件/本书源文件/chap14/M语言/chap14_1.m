I=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\pout.tif ');%读入并显示原始图像
I=double(I);                        %图像数据类型转换
[M,N]=size(I);
for i=1:M				            %进行现行灰度变换
for j=1:N
	    if I(i,j)<=30	 	
I(i,j)=I(i,j);
         elseif I(i,j)<=150
           I(i,j)=(200-30)/(150-30)*(I(i,j)-30)+30;  
         else
           I(i,j)=(255-200)/(255-150)*(I(i,j)-150)+200;
        end
end
end
figure,imshow(uint8(I));           %显示变换后的结果
