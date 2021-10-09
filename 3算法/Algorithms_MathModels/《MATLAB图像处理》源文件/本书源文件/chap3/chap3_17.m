close all;                                    %关闭当前所有图形窗口
clear all;                                     %清空工作空间变量
clc;                                         %清屏
I=zeros(128,128,1,27);                        %建立四维数组I
for i=1:27                                    
[I(:,:,:,i),map]=imread('mri.tif',i);              %读取多帧图像序列，存放在数组I中
end
set(0,'defaultFigurePosition',[100,100,1000,500]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
montage(I,map);                             %将多帧图像同时显示
