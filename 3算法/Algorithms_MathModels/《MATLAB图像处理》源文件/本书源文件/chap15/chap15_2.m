close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
proj1=90,N1=128;%输入投影数据大小
degree1=projdata(proj1,N1);%调用函数projdata产生头模型的投影数据
proj2=180,N2=256;%输入投影数据大小
degree2=projdata(proj2,N2);%调用函数projdata产生头模型的投影数据
set(0,'defaultFigurePosition',[100,100,1200,450]); %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])                 %修改图形背景颜色的设置
figure, 
subplot(121),pcolor(degree1)%显示180*128头模型    
subplot(122),pcolor(degree2)%显示180*256头模型    


