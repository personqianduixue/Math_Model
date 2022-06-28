close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('cameraman.tif');     %读取图像,赋值给I
J = filter2(fspecial('prewitt'), I); %对图像矩阵I进行滤波
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
K = imabsdiff(double(I),J);     %求滤波后的图像与原图像的绝对值差
figure,                          %显示图像及结果
subplot(131),imshow(I);       
subplot(132),imshow(J,[]);
subplot(133),imshow(K,[]);
X =[ 255 10 75; 44 225 100];%输入矩阵,数据格式double
Y =[ 50 50 50; 50 50 50 ];
X1 =uint8([ 255 10 75; 44 225 100]);%输入矩阵，数据格式uint8
Y1 =uint8([ 50 50 50; 50 50 50 ]);
Z=imabsdiff(X,Y)%求绝对值的差
Z1=abs(X-Y)     %利用函数abs计算绝对值差            
Z2=abs(X1-Y1)
disp('Z与Z1比较结果：'),Z_Z1=(Z==Z1)%比较不同数据类型下两种指令结果。
disp('Z与Z2比较结果：'),Z_Z2=(Z==Z2)