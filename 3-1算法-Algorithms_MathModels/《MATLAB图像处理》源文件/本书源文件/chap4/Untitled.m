close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
I = imread('flower.tif');
BW = im2bw(I,graythresh(I));
[B,L] = bwboundaries(BW,'noholes');
RGB=BW;
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(121);imshow(I);
subplot(122);imshow(RGB);
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end
