close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
N1=256;%输入头模型大小
[fp1,axes_x1,axes_y1,pixel1]=headata(N1);%调用函数headata产生头模型数据

set(0,'defaultFigurePosition',[100,100,1200,450]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure,                                     %显示256*256头模型            
subplot(121),
 for i=1:N1,
    for j=1:N1,
           a=fscanf(fp1,'%d  %d  %f\n',[1 3]);
           plot(axes_x1(i,j),axes_y1(i,j),'color',[0.5*a(3) 0.5*a(3) 0.5*a(3)],...
                                        'MarkerSize',20);
           hold on;
    end
 end
fclose(fp1);
N2=512;%输入头模型大小
[fp2,axes_x2,axes_y2,pixel2]=headata(N2);%调函数headata产生头模型数据 
 subplot(122),                          %显示512*512头模型
 for i=1:N2,
    for j=1:N2,
           a=fscanf(fp2,'%d  %d  %f\n',[1 3]);
           plot(axes_x2(i,j),axes_y2(i,j),'color',[0.5*a(3) 0.5*a(3) 0.5*a(3)],...
                                        'MarkerSize',20);
           hold on;
    end
 end
 fclose(fp2);