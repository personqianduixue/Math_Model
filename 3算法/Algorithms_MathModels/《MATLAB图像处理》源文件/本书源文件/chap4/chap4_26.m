close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
[I,map]=imread('peppers.png');  %读入图像
Ta = maketform('affine', ...
[cosd(30) -sind(30) 0; sind(30) cosd(30) 0; 0 0 1]');% 创建旋转参数结构体
Ia = imtransform(I,Ta);                              %实现图像旋转  
Tb = maketform('affine',[5 0 0; 0 10.5 0; 0 0 1]'); %创建缩放参数结构体
Ib = imtransform(I,Tb);%实现图像缩放  
xform = [1 0 55; 0 1 115; 0 0 1]';                    %创建图像平移参数结构体
Tc = maketform('affine',xform);
Ic = imtransform(I,Tc, 'XData', ...                   %进行图像平移
[1 (size(I,2)+xform(3,1))], 'YData', ...
[1 (size(I,1)+xform(3,2))],'FillValues', 255 );
Td = maketform('affine',[1 4 0; 2 1 0; 0 0 1]');% 创建图像整体切变的参数结构体
Id = imtransform(I,Td,'FillValues', 255);                          %实现图像整体切变
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure                 %显示结果
subplot(121),imshow(Ia),axis on;
subplot(122),imshow(Ib),axis on;
figure
subplot(121),imshow(Ic),axis on;
subplot(122),imshow(Id),axis on;
