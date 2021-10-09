close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load mask;% 载入图像和数据
A=X;
load bust; 
B=X;
Fus_Method = struct('name','userDEF','param','myfus_FUN'); % 定义融合规则和调用函数名
C=wfusmat(A,B,Fus_Method);%设置图像融合方法
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                 %创建图形显示窗口 
subplot(1,3,1), imshow(uint8(A)), %显示结果
subplot(1,3,2), imshow(uint8(B)), 
subplot(1,3,3), imshow(uint8(C)), 