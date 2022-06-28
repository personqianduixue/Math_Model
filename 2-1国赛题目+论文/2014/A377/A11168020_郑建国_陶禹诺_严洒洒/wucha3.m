%% 求水平位移随着主减速阶段下落距离变化的相对误差
clc;clear;close all;
g=1.633;  %月球重力加速度
m0=2.4*10^3;%卫星初始质量
Ve=2940;%比冲
theta=9.654*pi/180;%初速度与水平方向的夹角
F=7500;%推力
RECORD=[];
lisan=11950:5:12050;
for h=lisan
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
 RECORD=[RECORD;h,X_res];
end
temp=RECORD(find(RECORD(:,1)==12000),2);
XD=[RECORD(:,1),abs(RECORD(:,2)-temp)/temp];%相对误差。
%% 相对误差作图
plot(XD(:,1),XD(:,2),'LineWidth',2);
title('主减速阶段h改变时水平位移的相对误差趋势图','FontSize',14);
xlabel('主减速阶段下落高度（米）');
ylabel('相对误差');






