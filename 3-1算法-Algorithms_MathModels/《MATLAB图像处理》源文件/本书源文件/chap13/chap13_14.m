close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;     %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clc;
load detfingr; %导入图像数据
nbc=size(map,1);
[C,S]=wavedec2(X,2,'db4');%图像小波分解
thr_h=[21 46];            %设置水平分量阈值
thr_d=[21 46];            %设置对角分量阈值
thr_v=[21 46];            %设置垂直分量阈值   
thr=[thr_h;thr_d;thr_v]; 
[Xcompress2,cxd,lxd,perf0,perfl2]=wdencmp('lvd',X,'db3',2,thr,'h');%进行分层压缩
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
Y=wcodemat(X,nbc);
Y1=wcodemat(Xcompress2,nbc);
figure %显示原图像和压缩图像
colormap(map)
subplot(121),image(Y),axis square
subplot(122),image(Y1),axis square
figure
%colormap(map)
subplot(121),image(Y),axis square
subplot(122),image(Y1),axis square
disp('小波系数中置0的系数个数百分比：')  %显示压缩能量
perfl2
disp('压缩后图像剩余能量百分比：')
perf0
