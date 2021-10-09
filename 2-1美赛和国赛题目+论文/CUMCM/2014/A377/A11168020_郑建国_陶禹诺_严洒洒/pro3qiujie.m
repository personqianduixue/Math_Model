%% 粗避障阶段求解
%策略一：近似匀速直线运动
clc;clear;close all;
Ve=2940;%比冲
g=1.633;  %月球重力加速度
h=2300;   %该阶段的下落距离
t=0;          %初始时间
T=0.1;       %时间步长
%快速调整阶段的末状态量作为粗避障阶段的初状态量
Vy0=0.2208059;  %竖直初速度
m0=1278.72898;%初始质量
count=0; %计数器
Y_res=Vy0*t;
TIME=h/Vy0;%总运行时间。
Result=[];
%% 迭代求 分解速度和分解位移
M=m0;
consume=0;
while (Y_res<h )
count=count+1;
Y_res=Y_res+Vy0*T;
Time=count*T;
F=M*g;  %推力
consume=consume+F/Ve*T;
M=M-F/Ve*T;
end
M%该阶段的末质量。
Time  %运动时间
consume %总燃料消耗





