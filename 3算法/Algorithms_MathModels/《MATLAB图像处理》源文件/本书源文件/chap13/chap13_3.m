close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])  
iter = 4;            %设置采样点数
wav1 = 'db4';        %设置小波
wav2 = 'bior1.3'; 
[s,w1,w2,w3,xyval] = wavefun2(wav1,iter,'plot');%计算二维小波并显示
[s1,w11,w21,w31,xyval1] = wavefun2(wav2,iter,'plot');