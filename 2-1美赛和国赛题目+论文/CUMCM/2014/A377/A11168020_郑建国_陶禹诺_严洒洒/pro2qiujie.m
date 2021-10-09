%% 快速调整阶段的数值迭代求解。
clc;clear;close all;
Ve=2940;%比冲
g=1.633;  %月球重力加速度
h=600;%该阶段的下落距离
t=0; %初始时间
T=0.1;   %时间步长
M_temp=[];
V_temp=[];
shijian=[];
X_temp=[];
lisan=1500:100:7500;
%lisan=5000:5100;
for i = lisan
F=i;  %推力
%主减速阶段的末状态量作为快速调整阶段的初状态量
theta=55.6708*pi/180;%初速度与水平面的夹角
Vx0=32.23327;%水平初速度
Vy0=47.2005;  %竖直初速度
m0=1325.255;%初始质量
Ay0=g-F*sin(theta)/(m0-F/Ve*t);%竖直初加速度
Ax0=-F*cos(theta)/(m0-F/Ve*t);%水平初加速度
count=0; %计数器
X_res=Vx0*t+0.5*Ax0*t^2;
Y_res=Vy0*t+0.5*Ax0*t^2;
Result=[];

%% 迭代求 分解速度和分解位移
while (Y_res<h )
count=count+1;
Vx=Vx0+Ax0*T;
Vy=Vy0+Ay0*T;
Vx0=Vx;
Vy0=Vy;
X=Vx0*T+0.5*Ax0*T^2;
Y=Vy0*T+0.5*Ay0*T^2;
X_res=X_res+X;
Y_res=Y_res+Y;
 Time=count*T;
SIN=Vy/sqrt(Vy^2+Vx^2);
COS=Vx/sqrt(Vy^2+Vx^2);
Ay=g-F*SIN/(m0-F/Ve*Time);
Ax=-F*COS/(m0-F/Ve*Time);
Ax0=Ax;
Ay0=Ay;
end
M=m0-F/Ve*Time;%该阶段的末质量。
X_res; %水平位移
 Time=count*T;  %运动时间
 V_res=sqrt(Vx^2+Vy^2);%合速度
 jiaodu=atan(Vy/Vx)*180/pi; %末速度角度
 %Vx  %水平速度
M_temp=[M_temp;F/Ve*Time];
V_temp=[V_temp;V_res,Vx];
shijian=[shijian;Time];%记录运行时间
X_temp=[X_temp;X_res];
end
Answer=[lisan',M_temp,V_temp,shijian,X_temp];%结果总结在这里
subplot(221);
plot(lisan,M_temp,'LineWidth',2);
title('燃油消耗量关于推力变化图','FontSize',14);
xlabel('F_推（N）','FontSize',12);
ylabel('燃油消耗质量(千克)');

subplot(222);
plot(lisan,X_temp,'LineWidth',2);
title('水平位移关于推力变化图','FontSize',14);
xlabel('F_推（N）','FontSize',12);
ylabel('位移(米)');

subplot(223);
plot(lisan,V_temp(:,2),'LineWidth',2);
title('水平末速度关于推力变化图','FontSize',14);
xlabel('F_推（N）','FontSize',12);
ylabel('速度(米/秒)');

subplot(224);
plot(lisan,shijian,'LineWidth',2);
title('下落时间关于推力变化图','FontSize',14);
xlabel('F_推（N）','FontSize',12);
ylabel('时间(秒)');


%% 数据表格的写入。
M_temp=[];
V_temp=[];
shijian=[];
X_temp=[];
lisan=1500:7500;
for i = lisan
F=i;  %推力
%主减速阶段的末状态量作为快速调整阶段的初状态量
theta=55.6708*pi/180;%初速度与水平面的夹角
Vx0=32.23327;%水平初速度
Vy0=47.2005;  %竖直初速度
m0=1325.255;%初始质量
Ay0=g-F*sin(theta)/(m0-F/Ve*t);%竖直初加速度
Ax0=-F*cos(theta)/(m0-F/Ve*t);%水平初加速度
count=0; %计数器
X_res=Vx0*t+0.5*Ax0*t^2;
Y_res=Vy0*t+0.5*Ax0*t^2;
Result=[];

%% 迭代求 分解速度和分解位移
while (Y_res<h )
count=count+1;
Vx=Vx0+Ax0*T;
Vy=Vy0+Ay0*T;
Vx0=Vx;
Vy0=Vy;
X=Vx0*T+0.5*Ax0*T^2;
Y=Vy0*T+0.5*Ay0*T^2;
X_res=X_res+X;
Y_res=Y_res+Y;
 Time=count*T;
SIN=Vy/sqrt(Vy^2+Vx^2);
COS=Vx/sqrt(Vy^2+Vx^2);
Ay=g-F*SIN/(m0-F/Ve*Time);
Ax=-F*COS/(m0-F/Ve*Time);
Ax0=Ax;
Ay0=Ay;
end
M=m0-F/Ve*Time;%该阶段的末质量。
X_res; %水平位移
 Time=count*T;  %运动时间
 V_res=sqrt(Vx^2+Vy^2);%合速度
 jiaodu=atan(Vy/Vx)*180/pi; %末速度角度
 %Vx  %水平速度
M_temp=[M_temp;F/Ve*Time];
V_temp=[V_temp;V_res,Vx];
shijian=[shijian;Time];%记录运行时间
X_temp=[X_temp;X_res];
end
Answer=[lisan',M_temp,V_temp,shijian,X_temp];
%xlswrite('快速调整阶段各参数数据.xls',Answer);
%第一列是推力值
%第二列是燃料消耗量
%第三列是快速调整段末速度
%第四列是快速调整段的水平末速度
%第五列是运行时间
%第六列是水平位移

%%  最优轨迹图的绘制
figure;
M_temp=[];
V_temp=[];
shijian=[];
F=5085;  %推力
%主减速阶段的末状态量作为快速调整阶段的初状态量
theta=55.6708*pi/180;%初速度与水平面的夹角
Vx0=32.23327;%水平初速度
Vy0=47.2005;  %竖直初速度
m0=1325.255; %初始质量
Ay0=g-F*sin(theta)/(m0-F/Ve*t);%竖直初加速度
Ax0=-F*cos(theta)/(m0-F/Ve*t); %水平初加速度
count=0; %计数器
X_res=Vx0*t+0.5*Ax0*t^2;
Y_res=Vy0*t+0.5*Ax0*t^2;
Result=[];
G=[];
%% 迭代求 分解速度和分解位移
while (Y_res<h )
count=count+1;
Vx=Vx0+Ax0*T;
Vy=Vy0+Ay0*T;
Vx0=Vx;
Vy0=Vy;
X=Vx0*T+0.5*Ax0*T^2;
Y=Vy0*T+0.5*Ay0*T^2;
X_res=X_res+X;
Y_res=Y_res+Y;
 Time=count*T;
G=[G;X_res,Y_res,V_res,Time];
SIN=Vy/sqrt(Vy^2+Vx^2);
COS=Vx/sqrt(Vy^2+Vx^2);
Ay=g-F*SIN/(m0-F/Ve*Time);
Ax=-F*COS/(m0-F/Ve*Time);
Ax0=Ax;
Ay0=Ay;
end
plot(G(:,1),3000-G(:,2),'k','LineWidth',2);
title('快速调整段运动轨迹','FontSize',15);
xlabel('X轴/(m)');
ylabel('Y轴/(m)');







