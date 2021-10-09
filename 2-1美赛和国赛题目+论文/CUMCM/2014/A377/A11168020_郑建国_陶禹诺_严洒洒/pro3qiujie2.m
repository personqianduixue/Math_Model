%% 粗避障阶段求解
% 策略二  先无推力落体，再F推是恒力。
clc;clear;close all;tic;
Ve=2940;%比冲
g=1.633;  %月球重力加速度
h=2300;%该阶段的下落距离
t=0; %初始时间
T=0.1;   %时间步长
lisan=7458:0.001:7460;
TIME=[];
M=[];
V_res=[];
Result=[];
F_res=[];
for j=lisan
%快速调整阶段的末状态量作为粗避障阶段的初状态量
V0=0.2208059;  %竖直初速度
m0=1278.72898;%初始质量
count=0; %计数器
Y_res=V0*t;
Time=0;
%无推力落体下落最大时间T_max=52.9394466022199;
t1=45;%无推力落体下落时间t1
h1=V0*t1+0.5*g*t1^2;%无推力落体距离h1
h2=h-h1;%恒定推力制动距离h2
F=j;%恒定推力F
F_res=[F_res;F];
A0=g-F/(m0-F/Ve*t);%初始时刻加速度
V0=V0+g*t1; %推力段初速度
while (Y_res<h2 )
count=count+1;
Y=V0*T+0.5*A0*T^2;
V=V0+A0*T;
V0=V;
Y_res=Y_res+Y;
Time=count*T;
Ay=g-F/(m0-F/Ve*Time);
A0=Ay;
end
M=[M;m0-F/Ve*Time,F/Ve*Time];  %该阶段的末质量
TIME=[TIME;Time+t1];  %总运动时间
V_res=[V_res;V];
end
Result=[Result;TIME,V_res,M,F_res];
toc;








