%% 整个软着陆过程的运动轨迹
clc;clear;close all;
g=1.633;  %月球重力加速度
m0=2.4*10^3;%卫星初始质量
Ve=2940; %比冲
theta=9.654*pi/180;%初速度与水平方向的夹角
F=7500;   %推力
V0=1692.464; %近日点初速度
t=0;          %初始时间
T=0.1;       %时间步长
Vx0=V0*cos(-theta); %水平初速度
Vy0=V0*sin(-theta); %竖直初速度
Ay0=g-F*sin(-theta)/(m0-F/Ve*t);%竖直初加速度
Ax0=-F*cos(-theta)/(m0-F/Ve*t);%水平初加速度
count=0;
X_res=Vx0*t+0.5*Ax0*t^2;
Y_res=Vy0*t+0.5*Ax0*t^2;
Result=[];
h=12000;%主减速阶段的下落距离
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
GJ=[Result(:,1),15000-Result(:,2)];
%%
clc;close all;
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
GJ2=[G(:,1)+GJ(end,1),3000-G(:,2)];
flag1=[377092.173014911,2999.65005894814];%主减速段结束点
flag2=[377381.089941517,2399.99226916603];%快速调整段结束点
GJ3=[GJ;GJ2];
%plot(GJ3(:,1),GJ3(:,2));
hold on;
%plot(flag1(1,1),flag1(1,2),'o','MarkerSize',20);
%plot(flag2(1,1),flag2(1,2),'o','MarkerSize',20);
ttm=2399:-1:100;
CUBI=[zeros(2300,1)+flag2(1,1),ttm'];
GJ4=[GJ3;CUBI];
%plot(GJ4(:,1),GJ4(:,2));
flag3=[377381.089941517,100];%粗避障段结束点
%%
h=70;
aaa=1.98;
T=sqrt(2*h/g);
t1=0.5*T;
t2=t1;
x3=[];
y3=[];
x33=[];

for i=0:0.01:t1
x3=[x3;0.5*1.98*i^2];
end
temp5=x3(end,1);
vvv=aaa*t1;

for i=0:0.01:t2
x33=[x33;temp5+vvv*i-0.5*aaa*i^2];
end
X3=[x3;x33];
for i=0:0.01:T
y3=[y3;100-0.5*g*i^2];
end
x5=[GJ4(end,1)+X3];
GJ5=[GJ4;x5,y3];
%plot(GJ5(:,1),GJ5(:,2));
ttn=29:-1:0;
TT5=[zeros(30,1)+GJ5(end,1),ttn'];
GJ6=[GJ5;TT5];
plot(GJ6(:,1),GJ6(:,2),'LineWidth',2);
title('后4个过程的轨迹图','FontSize',14);
xlabel('水平位移/米');
ylabel('高度/米');
%axis([377092.173014911,377500,0 3000])