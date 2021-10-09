% GA main
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc
clear
bounds=ones(12,2);

global r

xmin=0; ymin=0; xmax=200; ymax=150;
r=25; n=6;
bounds(:,1)=zeros(12,1) + r;
bounds(1:6,2)=ones(6,1).*xmax - r;
bounds(7:12,2)=ones(6,1).*ymax - r;

% [x,endPop] = ga(bounds,'myfGAPLP',[],[],[1e-6 1 1]);
% [x,endPop] = ga('myfGAPLP',bounds,[],[],[1e-6 1 1]);
[x,endPop]= ga(@fGAPLP,12,[],[],[],[],bounds(:,1),bounds(:,2))
%subplot(1,2,1)
myfplotcircleGA(x,r,xmax,ymax);
xlabel('横坐标/m')
ylabel('纵坐标/m')
title('遗传算法的结果')

