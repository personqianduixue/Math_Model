clc,clear,close all
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global T_real index
global Data
global len0 len1 len2 len3 len4 len5
load Data
T15=173;T06=198;T07=230;T89=257;T1011=25;l=30.5;a=5;b=25;deltat=0.5;d=0.015;deltax=0.001;
index=Data(:,1)/deltat+1;
T_real = Data(:,2);
max_up_xielv=zeros(1,length(65:1:100));
max_down_xielv=zeros(1,length(65:1:100));
t_between150_190_all=zeros(1,length(65:1:100));
t_up217_all=zeros(1,length(65:1:100));
maxT_all=zeros(1,length(65:1:100));
for vi=65:1:100
    v=vi/60;
    ts=getTs();
    len0=floor((b)/(v*deltat));
    len1=floor((b+5*l+4*a)/(v*deltat));
    len2=floor((b+6*l+5*a)/(v*deltat));
    len3=floor((b+7*l+6*a)/(v*deltat));
    len4=floor((b+9*l+8*a)/(v*deltat));
    len5=floor((b+11*l+10*a+25)/(v*deltat));
    load alpha_beta1.mat
    t=0:deltat:(b+11*l+10*a+25)/v;
    T_problem2=getTt(alpha_beta(1:5),alpha_beta(6));
    [isOK,up_xielv,down_xielv,t_between150_190,t_up217,maxT]=condition(T_problem2);
    max_up_xielv(vi-64)=max(up_xielv);
    max_down_xielv(vi-64)=min(down_xielv);
    t_between150_190_all(vi-64)=t_between150_190;
    t_up217_all(vi-64)=t_up217;
    maxT_all(vi-64)=maxT;
    if isOK
        vmax=v*60;%vmax=78
    end
end
vi=65:1:100;
figure('Position',[97.8,342.6,762.4,327.2])
subplot(221)
plot(vi,max_up_xielv,vi,max_down_xielv),xlabel('速度v cm/s'),title('最大斜率')
legend('上升斜率','下降斜率','Orientation','vertical')
subplot(222)
plot(vi,t_between150_190_all),xlabel('速度v cm/s'),ylabel('时间'),title('温度上升过程中在150-190度的时间')
subplot(223)
plot(vi,t_up217_all),xlabel('速度v cm/s'),ylabel('时间'),title('温度大于217度的时间')
subplot(224)
plot(vi,maxT_all),xlabel('速度v cm/s'),ylabel('峰值温度');title('峰值温度'),beautiplot('small')
exportgraphics(gcf,'img\问题2各个指标随速度的变化.png','Resolution',400)
%%
for vi=77:0.01:79
    v=vi/60;
    ts=getTs();
    len0=floor((b)/(v*deltat));
    len1=floor((b+5*l+4*a)/(v*deltat));
    len2=floor((b+6*l+5*a)/(v*deltat));
    len3=floor((b+7*l+6*a)/(v*deltat));
    len4=floor((b+9*l+8*a)/(v*deltat));
    len5=floor((b+11*l+10*a+25)/(v*deltat));
    load alpha_beta1.mat
    t=0:deltat:(b+11*l+10*a+25)/v;
    T_problem2=getTt(alpha_beta(1:5),alpha_beta(6));
    [isOK,up_xielv,down_xielv,t_between150_190,t_up217,maxT]=condition(T_problem2);
    if isOK
        vmax=v*60;%vmax=78.95
    end
end
vmax
