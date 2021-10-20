clc,clear,close all
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global T_real index
global Data
global len0 len1 len2 len3 len4 len5
load Data
T15=175;T06=195;T07=235;T89=255;T1011=25;v=70/60;l=30.5;a=5;b=25;deltat=0.5;d=0.015;deltax=0.001;
ts=getTs();
index=Data(:,1)/deltat+1;
T_real = Data(:,2);
len0=floor((b)/(v*deltat));
len1=floor((b+5*l+4*a)/(v*deltat));
len2=floor((b+6*l+5*a)/(v*deltat));
len3=floor((b+7*l+6*a)/(v*deltat));
len4=floor((b+9*l+8*a)/(v*deltat));
len5=floor((b+11*l+10*a+25)/(v*deltat));
for alpha1=
t=0:deltat:(b+11*l+10*a+25)/v;
Tt_M=getTt(alpha_beta(1:5),alpha_beta(6));
plot(t,Tt_M);hold on
plot(Data(:,1),Data(:,2));xlabel('时间t/s');ylabel('温度T/^{\circ}C')
legend('拟合曲线','实际曲线','Location','best');beautiplot

