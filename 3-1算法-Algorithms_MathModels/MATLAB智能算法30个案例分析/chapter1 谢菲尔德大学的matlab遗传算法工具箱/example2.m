clc
clear all
close all
%% 画出函数图
figure(1);
lbx=-2;ubx=2; %函数自变量x范围【-2,2】
lby=-2;uby=2; %函数自变量y范围【-2,2】
ezmesh('y*sin(2*pi*x)+x*cos(2*pi*y)',[lbx,ubx,lby,uby],50);   %画出函数曲线
hold on;
%% 定义遗传算法参数
NIND=40;        %个体数目
MAXGEN=50;      %最大遗传代数
PRECI=20;       %变量的二进制位数
GGAP=0.95;      %代沟
px=0.7;         %交叉概率
pm=0.01;        %变异概率
trace=zeros(3,MAXGEN);                        %寻优结果的初始值
FieldD=[PRECI PRECI;lbx lby;ubx uby;1 1;0 0;1 1;1 1];                      %区域描述器
Chrom=crtbp(NIND,PRECI*2);                      %初始种群
%% 优化
gen=0;                                  %代计数器
XY=bs2rv(Chrom,FieldD);                 %计算初始种群的十进制转换
X=XY(:,1);Y=XY(:,2);
ObjV=Y.*sin(2*pi*X)+X.*cos(2*pi*Y);        %计算目标函数值
while gen<MAXGEN
   FitnV=ranking(-ObjV);                              %分配适应度值
   SelCh=select('sus',Chrom,FitnV,GGAP);              %选择
   SelCh=recombin('xovsp',SelCh,px);                  %重组
   SelCh=mut(SelCh,pm);                               %变异
   XY=bs2rv(SelCh,FieldD);               %子代个体的十进制转换
   X=XY(:,1);Y=XY(:,2);
   ObjVSel=Y.*sin(2*pi*X)+X.*cos(2*pi*Y);             %计算子代的目标函数值
   [Chrom,ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel); %重插入子代到父代，得到新种群
   XY=bs2rv(Chrom,FieldD);
   gen=gen+1;                                             %代计数器增加
   %获取每代的最优解及其序号，Y为最优解,I为个体的序号
   [Y,I]=max(ObjV);
   trace(1:2,gen)=XY(I,:);                       %记下每代的最优值
   trace(3,gen)=Y;                               %记下每代的最优值
end
plot3(trace(1,:),trace(2,:),trace(3,:),'bo');                            %画出每代的最优点
grid on;
plot3(XY(:,1),XY(:,2),ObjV,'bo');  %画出最后一代的种群
hold off
%% 画进化图
figure(2);
plot(1:MAXGEN,trace(3,:));
grid on
xlabel('遗传代数')
ylabel('解的变化')
title('进化过程')
bestZ=trace(3,end);
bestX=trace(1,end);
bestY=trace(2,end);
fprintf(['最优解:\nX=',num2str(bestX),'\nY=',num2str(bestY),'\nZ=',num2str(bestZ),'\n'])
