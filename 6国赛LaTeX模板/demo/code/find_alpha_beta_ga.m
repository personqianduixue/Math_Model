clc,clear,close all
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global T_real index
global Data
global len0 len1 len2 len3 len4 len5
load Data
T15=175;T06=195;T07=235;T89=255;T1011=25;v=70/60;l=30.5;a=5;b=25;deltat=0.5;d=0.015;deltax=0.001;
ts=getTs();
t=0:deltat:(b+11*l+10*a+25)/v;
figure('Position',[483.4,390.6,560,299])
plot(t,ts),xlabel('时间/s'),ylabel('空气温度{ }^{\circ} C')
beautiplot
exportgraphics(gcf,'img\空气温度趋势图.png','Resolution',400)
%%
index=Data(:,1)/deltat+1;
T_real = Data(:,2);
len0=floor((b)/(v*deltat));
len1=floor((b+5*l+4*a)/(v*deltat));
len2=floor((b+6*l+5*a)/(v*deltat));
len3=floor((b+7*l+6*a)/(v*deltat));
len4=floor((b+9*l+8*a)/(v*deltat));
len5=floor((b+11*l+10*a+25)/(v*deltat));
options = optimoptions(@ga,...
    'Display','off','Generations', 150, 'StallGenLimit', 200, 'PlotFcns', 'gaplotbestf');%,'Migrationfraction', 0.3);
number=6;
[alpha_beta,objvalue]=ga(@problem0_fitness ,number,[],[],[],[],[zeros(1,number-1),1e+4],[ones(1,number-1)*(1e-6),1e+5],[],options);
%%
load alpha_beta1.mat
t=0:deltat:(b+11*l+10*a+25)/v;
Tt_M=getTt(alpha_beta(1:5),alpha_beta(6));
figure('Position',[276.2,356.2,709,307.2])
Dt1=problem0_fitness(alpha_beta)
plot(t,Tt_M);hold on
plot(Data(:,1),Data(:,2));xlabel('时间t/s');ylabel('温度T/^{\circ}C')
legend('拟合曲线','实际曲线','Location','best');beautiplot
exportgraphics(gcf,'img\拟合.png','Resolution',400)
[R,P]=corrcoef(T_real,Tt_M(index));
R2=R(1,2)


t=0:deltat:(b+11*l+10*a+25)/v;
% Tt_M1=getTt([4 5 7 4 2]*(1e-7),14.458e-4/1.67e-8);
Tt_M1=getTt([3.9 5.1 6.5 4.7 2.1]*(1e-7),9000);
Dt2=problem0_fitness([[3.9 5.1 6.5 4.7 2.1]*(1e-7),9000])
% Tt_M=getTt([4.437 5.621 7.449 4.997 2.401]*(1e-7),14.458e-4/1.67e-8);
figure('Position',[276.2,356.2,709,307.2])
plot(t,Tt_M1);hold on
plot(Data(:,1),Data(:,2));xlabel('时间t/s');ylabel('温度T/^{\circ}C')
legend('拟合曲线1','实际曲线','Location','best');beautiplot

