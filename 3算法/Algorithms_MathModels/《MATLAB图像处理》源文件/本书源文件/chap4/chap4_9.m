close all;                   %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc
A=imread('tire.tif');        %读取图像tire，并赋值给A
[m,n]=size(A);               %获取图像矩阵A的行列数m，n
B=imread('eight.tif');      %读取图像eight的值，并赋值给B
C=B;                        %初始化矩阵C
A=im2double(A);           %定义A\B\C的数据类型为双精度  
B=im2double(B);
C=im2double(C);
for i=1:m                      %将图像B和A叠加，结果赋值给C
    for j=1:n
    C(i,j)=B(i,j)+A(i,j);   
    end
end
D=imabsdiff(C,B);           %求叠加后图像C和B的差异，赋值给D     
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure(1),
subplot(121),imshow(A); %显示tire、eight图像，叠加图像及差异图像
subplot(122),imshow(B);
figure(2),
subplot(121),imshow(C);
subplot(122),imshow(D);
