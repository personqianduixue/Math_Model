close all;                          %关闭当前所有图形窗口
clear all                           %清空工作空间变量
clc;                               %清屏
set(0,'defaultFigurePosition',[100,100,1000,500]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
h = imshow('hestain.png');                        %显示图像
hp = impixelinfo;                                 %创建图像像素信息显示工具
set(hp,'Position',[150 290 300 20]);                 %设置像素信息工具显示的位置
figure
imshow('trees.tif');
impixelinfo                                 %创建图像像素信息显示工具
