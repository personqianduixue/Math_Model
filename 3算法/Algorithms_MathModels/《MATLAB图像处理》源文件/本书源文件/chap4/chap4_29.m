close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('peppers.png'); %输入图像
fun = @(block_struct) imrotate(block_struct.data,30);%获取分离块操作的函数句柄
I1 = blockproc(I,[64 64],fun);              %进行分离块操作
fun = @(block_struct) std2(block_struct.data) ;  %获取获取分离块操作的函数句柄
I2 = blockproc(I,[32 32],fun);%进行分离块操作
fun = @(block_struct) block_struct.data(:,:,[3 1 2]);%获取分离块操作的函数句柄
blockproc(I,[100 100],fun,'Destination','brg_peppers.tif');%进行分离块操作
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure%显示处理后结果
subplot(131),imshow(I1);
subplot(132),imshow(I2,[]);
subplot(133),imshow('brg_peppers.tif');