close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;     %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clc;
load detfingr; %导入图像数据
nbc=size(map,1);%获取颜色映射阶数
[c,s]=wavedec2(X,3,'sym4');%对图像数据X进行3层小波分解 采用小波函数sym4
alpha=1.5;%设置参数alpha和m，利用wdcbm2设置图像压缩的分层阈值
m=2.7*prod(s(1,:)); 
[thr,nkeep]=wdcbm2(c,s,alpha,m)
[xd,cxd,sxd,perf0,perfl2] =wdencmp('lvd',c,s,'sym4',3,thr,'h');
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                 %创建图形显示窗口
colormap(pink(nbc));
subplot(121), image(wcodemat(X,nbc)),
subplot(122), image(wcodemat(xd,nbc)),
disp('小波系数中置0的系数个数百分比：')   %输出压缩比率变量
perfl2
disp('压缩后图像剩余能量百分比：')
perf0
