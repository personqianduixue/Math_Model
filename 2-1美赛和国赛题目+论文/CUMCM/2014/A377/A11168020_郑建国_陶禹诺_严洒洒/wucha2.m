%% 主减速阶段的灵分析2。
clc;clear;close all;
g=1.633;  %月球重力加速度
m0=2.4*10^3;%卫星初始质量
Ve=2940;%比冲
theta=9.654*pi/180;%初速度与水平方向的夹角

RECORD=[];
lisan=7000:7500
for F=lisan%推力

h=12000;
%主减速阶段的下落距离h
V0=1692.464; %近日点初速度
t=0; %初始时间
T=0.1;   %时间步长
Vx0=V0*cos(-theta); %水平初速度
Vy0=V0*sin(-theta); %竖直初速度
Ay0=g-F*sin(-theta)/(m0-F/Ve*t);%竖直初加速度
Ax0=-F*cos(-theta)/(m0-F/Ve*t);%水平初加速度
count=0;
X_res=Vx0*t+0.5*Ax0*t^2;
Y_res=Vy0*t+0.5*Ax0*t^2;
Result=[];

%% 迭代求 分解速度和分解位移
while (Y_res<h )
count=count+1;
Vx=Vx0+Ax0*T;
Vy=Vy0+Ay0*T;
V_res=sqrt(Vx^2+Vy^2);
Vx0=Vx;
Vy0=Vy;
X=Vx0*T+0.5*Ax0*T^2;
Y=Vy0*T+0.5*Ay0*T^2;
X_res=X_res+X;
Y_res=Y_res+Y;
 Time=count*T;
 Result=[Result;X_res,Y_res,V_res,Time];
SIN=Vy/sqrt(Vy^2+Vx^2);
COS=Vx/sqrt(Vy^2+Vx^2);
Ay=g-F*SIN/(m0-F/Ve*Time);
Ax=-F*COS/(m0-F/Ve*Time);
Ax0=Ax;
Ay0=Ay;
end
M=m0-F/Ve*Time;%该阶段的末质量。
%X_res  %水平位移
 Time=count*T;  %运动时间
 V_res=sqrt(Vx^2+Vy^2) ;%合速度
 jiaodu=atan(Vy/Vx)*180/pi;%末速度角度。
 consume=F/Ve*Time;%燃料消耗量
 RECORD=[RECORD;h,consume,M,Time,V_res,X_res,jiaodu];
end
flag=320;
str={'主减速燃料消耗关于F变化图','主减速阶段末质量关于F变化图',...
    '主减速阶段总时间关于F变化图','主减速阶段末速度关于F变化图',...
    '主减速阶段水平位移关于F变化图','末速度与水平方向的夹角关于F变化图'};
str1={'燃料消耗质量（千克）','质量（千克）','时间（秒）','速度（米/秒）'...
    '位移（米）','角度（度）'};
for i=1:6
    flag=flag+1;
    subplot(flag);
    plot(lisan,RECORD(:,i+1),'LineWidth',2);
    ylabel(str1(i));
    xlabel('主减速阶段恒定推力F（N）');
    title(str(i));
end







