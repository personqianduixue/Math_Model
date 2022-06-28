close all;                          %关闭当前所有图形窗口
clear all;                           %清空工作空间变量
clc;                               %清屏
RGB = imread('peppers.png');        %读取图像信息
c = [12 146 410];                   %新建一个向量c，存放像素纵坐标
r = [104 156 129];                   %新建一个向量r，存放像素横坐标
set(0,'defaultFigurePosition',[100,100,1000,500]);    %修改图形图像位置的默认设置
set(0,'defaultFigureColor', [1 1 1])                  %修改图形背景颜色的设置
pixels1=impixel(RGB)               %交互式用鼠标选择像素
pixels2= impixel(RGB,c,r)            %将像素坐标作为输入参数，显示特定像素的颜色值
