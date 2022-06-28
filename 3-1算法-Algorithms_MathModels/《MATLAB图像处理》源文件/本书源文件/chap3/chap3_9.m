close all;                                       %关闭当前所有图形窗口
clear all;                                        %清空工作空间变量
clc;                                             %清屏
load trees;                                       %从文件‘trees。mat’中载入数据到workplace
BW = im2bw(X,map,0.4);                          %将缩=索引图像转换为二值图像
set(0,'defaultFigurePosition',[100,100,1000,500]);   %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1]);                %修改图形背景颜色的设置
figure, imshow(X,map);         %显示原索引图像
figure, imshow(BW);           %显示转换后二值图像
