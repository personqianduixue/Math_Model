clc,clear, close all
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global len0 len1 len2 len3 len4 len5
global alpha_beta
load alpha_beta1.mat
T1011=25;l=30.5;a=5;b=25;deltat=0.5;d=0.015;deltax=0.001;
lb=[165,185,225,245,65];
ub=[185,205,245,265,100];
options = optimoptions(@ga,...
    'Display','off','Generations', 1000, 'StallGenLimit', 300,'Migrationfraction', 0.3);%'PlotFcns', 'gaplotbestf'
number=5;
problem3_Data=[];
for i=1:10
    [T_all,Fit]=ga(@evaluateS ,number,[],[],[],[],lb,ub,[],options);
    T_all
    T15=T_all(1);T06=T_all(2);T07=T_all(3);T89=T_all(4);v=T_all(5)/60;
    ts=getTs();
    len0=floor((b)/(v*deltat));
    len1=floor((b+5*l+4*a)/(v*deltat));
    len2=floor((b+6*l+5*a)/(v*deltat));
    len3=floor((b+7*l+6*a)/(v*deltat));
    len4=floor((b+9*l+8*a)/(v*deltat));
    len5=floor((b+11*l+10*a+25)/(v*deltat));
    S_problem3=Fit;
    T_problem3=getTt(alpha_beta(1:5),alpha_beta(6));
    T_max_problem3=max(T_problem3)
 
    tmp=[T_all,S_problem3,T_max_problem3];
    problem3_Data=[problem3_Data;tmp];
end
save problem3_Data
%%
t=0:deltat:(b+11*l+10*a+25)/v;
figure('Position',[483.4,390.6,560,299])
plot(t,T_problem3)
xlabel('时间t/s');ylabel('温度T/^{\circ}C');title('问题3炉温曲线');beautiplot
exportgraphics(gcf,'img\问题3炉温曲线.png','Resolution',400)