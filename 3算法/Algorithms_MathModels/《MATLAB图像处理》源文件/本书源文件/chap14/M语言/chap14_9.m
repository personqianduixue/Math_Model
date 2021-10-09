A=imread('D:\Program Files\MATLAB\R2010a\toolbox\images\imdemos\office_4.jpg');                                %读取并显示图像
B=size(A);                                             %图像切变
C=zeros(B(1)+round(B(2)*tan(pi/6)),B(2),B(3));
for m=1:B(1)
     for n=1:B(2)
        C(m+round(n*tan(pi/6)),n,1:B(3))=A(m,n,1:B(3));
end
end
figure,imshow(uint8(C));                              %显示切变后图像
