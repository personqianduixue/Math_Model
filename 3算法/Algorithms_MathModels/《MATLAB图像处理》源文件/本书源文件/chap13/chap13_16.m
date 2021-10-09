close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load wbarb;                 %导入图像数据
[C,S] = wavedec2(X,3,'db4');%进行小波分解
[thr,sorh,keepapp] = ddencmp('cmp','wv',X)%返回图像压缩所需要的一些参数
[Xcomp,CXC,LXC,PERF0,PERFL2] =wdencmp('gbl',C,S,'db4',3,thr,sorh,keepapp);%按照参数压缩图像，并返回结果
disp('小波系数中置0的系数个数百分比：') %返回压缩比率
PERFL2
disp('压缩后图像剩余能量百分比：')
PERF0
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure;            %创建图像               
colormap(map);
subplot(121); image(X); axis square%显示压缩结果
subplot(122); image(Xcomp); axis square


