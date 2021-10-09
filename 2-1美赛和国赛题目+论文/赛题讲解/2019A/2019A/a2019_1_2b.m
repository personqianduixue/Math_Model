clear; clc;   %问题1.2
global p0 C A V
p0=160; C=0.85; A=pi*1.4^2/4; V=pi*25*500;

[p,t]=f1(0.7643,4,0.7524,100);
s=mean(p(4500000:5000000));
figure
ax=subplot(1,1,1);
plot(ax,t*0.001,p);
title(ax,'前4s T=0.7643,其后T=0.7524时的压强和时间(s)的关系');




a1=0.76; a2=0.8;                   
while 1
    tmp=(a1+a2)/2;
    [p,~]=f1(tmp,4,0.7524,100);
    s=mean(p(4500000:5000000));
    if s<150
        a1=tmp;
    else
        a2=tmp;
    end
    if(a2-a1)<=0.0001
        break;
    end
end
T=(a1+a2)/2;     % T=0.7643




function rho=dens(p)         %密度压强的关系
    n=length(p);rho=zeros(n,1);
    for i=1:n      
        s=integral(@(x) 1./sc(x),100,p(i));
        rho(i)=0.850*exp(s);
    end
end

function e=sc(x)    %弹性模量
    p1=3.986e-12;p2=-1.196e-09;p3=2.909e-07;p4=1.024e-05;p5=0.0116;p6=4.857;p7=1538;
    e=p1*x.^6 + p2*x.^5 + p3*x.^4 + p4*x.^3 + p5*x.^2 +p6.*x + p7;
end

function y=q(t)      %B处流量函数
    s=mod(t,100);
    y=100.*s.*(s>=0).*(s<=0.2)+20.*(0.2<s).*(s<=2.2)+(240-100.*s).*(2.2<s).*(s<=2.4)+0.*(2.4<s).*(s<=100);
end

function y=eta(t,a,T)  %A处流量函数， T阀开时长， a 初次开阀时间
    s=mod(t-a,T+10);
    y=(0<=s).*(s<=T);
end

function [p,t]=f(time,T,p1)  %time 总时长， T 开阀时间
    global p0 A C V
    h=0.001; n=floor(time*1000/h)+1; a=0;
    t=(0:n-1)*h;       %时间列
    p=zeros(n,1);      %对应的压强
    midu=zeros(n,1);   %对应的密度
    rho0=dens(p0); p(1)=p1;  midu(1)=dens(p1);
    tmp1=h*C*A*eta(t,a,T)*sqrt(2*rho0)/V;
    tmp2=h*q(t)/V;
    for i=1:n-1
        tmp=tmp1(i)*sqrt(p0-p(i))-midu(i)*tmp2(i);
        midu(i+1)=midu(i)+tmp;
        p(i+1)=p(i)+tmp*sc(p(i))/midu(i);
    end
end

function [p,t]=f1(t1,t2,t3,p1)  %t1 前段开阀时间， t2 间断点， t3 后端开阀时长， p1初始压强， 总模拟时间10s
    global p0 A C V
    h=0.001; n=floor(10*1000/h)+1; a=0;   d=floor(t2*1000/h)+1;
    t=(0:n-1)*h;       %时间列
    p=zeros(n,1);      %对应的压强
    midu=zeros(n,1);   %对应的密度
    rho0=dens(p0); p(1)=p1;  midu(1)=dens(p1);
    tmp1=h*C*A*[eta(t(1:d),a,t1),eta(t(d+1:n),a,t3)]*sqrt(2*rho0)/V;
    tmp2=h*q(t)/V;
    for i=1:n-1
        tmp=tmp1(i)*sqrt(p0-p(i))-midu(i)*tmp2(i);
        midu(i+1)=midu(i)+tmp;
        p(i+1)=p(i)+tmp*sc(p(i))/midu(i);
    end
end

