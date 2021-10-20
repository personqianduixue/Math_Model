clc,clear,close all
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global T_real index
global Data
global len0 len1 len2 len3 len4 len5
load Data
T15=173;T06=198;T07=230;T89=257;T1011=25;v=78/60;l=30.5;a=5;b=25;deltat=0.5;d=0.015;deltax=0.001;
ts=getTs();
index=Data(:,1)/deltat+1;
T_real = Data(:,2);
len0=floor((b)/(v*deltat));
len1=floor((b+5*l+4*a)/(v*deltat));
len2=floor((b+6*l+5*a)/(v*deltat));
len3=floor((b+7*l+6*a)/(v*deltat));
len4=floor((b+9*l+8*a)/(v*deltat));
len5=floor((b+11*l+10*a+25)/(v*deltat));
load alpha_beta1.mat
t=0:deltat:(b+11*l+10*a+25)/v;
T_problem1=getTt(alpha_beta(1:5),alpha_beta(6));
figure('Position',[483.4,390.6,560,299])
plot(t,T_problem1);xlabel('时间t/s');ylabel('温度T/^{\circ}C');title('问题1炉温曲线');beautiplot
exportgraphics(gcf,'img\问题1炉温曲线.png','Resolution',400)
t_wenqv3=(b+2*l+2*a+l/2)/v;
t_wenqv6=(b+5*l+5*a+l/2)/v;
t_wenqv7=(b+6*l+6*a+l/2)/v;
t_wenqv8=(b+8*l+7*a+l/2)/v;
T_wenqv3=(T_problem1(floor(t_wenqv3/deltat)+1)+T_problem1(floor(t_wenqv3/deltat)+2))/2;
T_wenqv6=(T_problem1(floor(t_wenqv6/deltat)+1)+T_problem1(floor(t_wenqv6/deltat)+2))/2;
T_wenqv7=(T_problem1(floor(t_wenqv7/deltat)+1)+T_problem1(floor(t_wenqv7/deltat)+2))/2;
T_wenqv8=(T_problem1(floor(t_wenqv8/deltat)+1)+T_problem1(floor(t_wenqv8/deltat)+2))/2;
t_T_problem1_wenqv=table([T_wenqv3,T_wenqv6,T_wenqv7,T_wenqv8]);
writetable(t_T_problem1_wenqv,'温区点温度.csv')
t_T_problem1=table([t',T_problem1']);
writetable(t_T_problem1,'result.csv')
%%
figure('Position',[483.4,390.6,560,299])
plot()
