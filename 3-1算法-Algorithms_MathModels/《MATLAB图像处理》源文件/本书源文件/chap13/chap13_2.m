close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
[phi,psi,xval]=wavefun('sym4',10);          %得到sym4的尺度函数和小波函数
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])  
subplot(121);plot(xval,phi,'k');        %显示尺度函数
axis([0 8 -0.5 1.3]);
axis square;
subplot(122); plot(xval,psi,'k');        %显示小波函数
axis([0 8 -1.5 1.6]);
axis square; 
[lo_d,hi_d,lo_r,hi_r]=wfilters('sym4');         %得到sym4的相关滤波器
figure                                 %显示相关滤波器
subplot(121);stem(lo_d,'.k');
subplot(122);stem(hi_d,'.k');
figure
subplot(121);stem(lo_r,'.k');
subplot(122);stem(hi_r,'.k');
