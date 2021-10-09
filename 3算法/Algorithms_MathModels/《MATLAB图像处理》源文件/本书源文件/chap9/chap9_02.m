close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
RGB = imread('board.tif');						%读入RGB图像
YCBCR = rgb2ycbcr(RGB);					%将RGB图像转换为YCBCR图像
figure;
subplot(121), imshow(RGB)					%显示RGB图像
subplot(122), imshow(YCBCR)					%显示YCBCR图像
