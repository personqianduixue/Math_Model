close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load wmandril;            %导入图像数据
nbc=size(map,1);          %获取颜色映射阶数       
Y=wcodemat(X,nbc);%对图像的数值矩阵进行伪彩色编码
[C,S]=wavedec2(X,2,'db4'); %对图像小波分解
thr=20;                  %设置阈值
[Xcompress1,cxd,lxd,perf0,perfl2]=wdencmp('gbl',C,S,'db4',2,thr,'h',1);%对图像进行全局压缩
Y1=wcodemat(Xcompress1,nbc); %对图像数据进行伪彩色编码
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                 %创建图形显示窗口
colormap(gray(nbc));       %设置映射谱图等级
subplot(121),image(Y),axis square %显示
subplot(122);image(Y1),axis square
disp('小波系数中置0的系数个数百分比：')   %输出压缩比率变量
perfl2
disp('压缩后图像剩余能量百分比：')
perf0
