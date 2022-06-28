close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
x=0:0.1:10;
y1=sin(2.*x);
y2=2.*sin(x);
plot(x,y1,'b*:',x,y2,'r+-');						%设置颜色、顶点和线型
axis([0 pi 0 2 ]);								%设置坐标轴
title('正弦曲线');								%设置标题行
xlabel('时间/单位：秒');ylabel('电压/单位：伏特');	%设置横坐标纵坐标
gtext('y=sin(2x)');							%在图中鼠标指定位置添加文字y=sin(2x)
gtext(2.5,1.5,'y=2sin(x)');						%在图中(2.5, 1.5)处添加文字y=2sin(x)
grid;										%设置栅格
