clear all  %清除当前命令窗口，关闭当前窗口，清除命令
close all
clc
load woman; %导入图像
X1=X;map1=map;%保存图像数据和映射
load wbarb;%导入图像
X2=X;map2=map;%保存图像数据和映射
[C1,S1]=wavedec2(X1,2,'sym4');%图像的小波分解
[C2,S2]=wavedec2(X2,2,'sym4');
C=1.2*C1+0.5*C2;             %对图像的小波分解结果进行融合方案1
C=0.4*C;
C0=0.2*C1+1.5*C2;   %对图像的小波分解结果进行融合方案2
C0=0.5*C;
xx1=waverec2(C,S1,'sym4');%对小波分解的结果进行融合处理
xx2=waverec2(C0,S2,'sym4');
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure                 %创建图形显示窗口
colormap(map2),
subplot(121),image(X1) %显示原图像和融合结果
subplot(122),image(X2)
figure                 %创建图形显示窗口
colormap(map2),
subplot(121),image(xx1);
subplot(122),image(xx2);