clear; clc;

a1=10;a2=40;
while 1
    tmp=(a1+a2)/2;
    [p,~]=f(10,tmp);
    s=mean(p(900000:1000000));
    if s<100
        a1=tmp;
    else
        a2=tmp;
    end
    if a2-a1<=0.001
        break;
    end
end

w=(a1+a2)/2;
[p,t]=f(10,w);
figure
ax1=subplot(1,1,1);
plot(ax1,t*0.001,p);
title(ax1,['在10s内角速度为',num2str(w),'rad/s时 压强和时间的关系']);


function  y=Section_Area(h)     %B处 出油口面积
    t=tan(pi/20);s=sin(pi/20);
    A1=pi*0.7^2; A2=pi*s*(2.5+t*h).*h;
    y=(A2>A1).*A1+(A2<=A1).*A2;
end

function h=height(t)     % B处 升程函数
    a1=2.017;b1=0.4552;c1=0.1662; b2=1.994;
    s=mod(t,100);
    h=a1*(s<=0.45).*exp(-((s-b1)/c1).^2)+2*(s>0.45).*(s<=2)+a1*(s>2).*(s<=2.45).*exp(-((s-b2)/c1).^2);

end

function r=rad(w,t)  % 凸轮极径函数， w角速度
    c=4.826; b=2.413;
    r=c-b*cos(w*t);
end

function e=sc(x)    %弹性模量
    p1=3.986e-12;p2=-1.196e-09;p3=2.909e-07;p4=1.024e-05;p5=0.0116;p6=4.857;p7=1538;
    e=p1*x.^6 + p2*x.^5 + p3*x.^4 + p4*x.^3 + p5*x.^2 +p6.*x + p7;
end

function V=Volume(w,t)  %活塞腔体体积  w rad/s   t:ms
    S=pi*6.25*2.413;
    V=20+S*(1+cos(w*t*0.001));
end

function rho=dens(p)         %密度压强的关系
    n=length(p);rho=zeros(n,1);
    for i=1:n      
        s=integral(@(x) 1./sc(x),100,p(i));
        rho(i)=0.850*exp(s);
    end
end
function [p,t]=f(time,w)  %求解方程组 time 模拟时长，w 角速度  rad/s
    h=0.01;  %时间间隔
    n=floor(time*1000/h)+1;
    k=floor(time*w/(2*pi))+1;
    j=floor((0:k-1)*1000*2*pi/w/h)+1;
    t=(0:n-1)*h;P=zeros(1,n);p=P;rho=P;Rho=P;m=P;
    P(1)=0.5;p(1)=100;rho(1)=0.85; Rho(1)=dens(0.5);
    CA=sqrt(2)*0.85*pi*1.4^2/4; V0=pi*25*500;
    V=Volume(w,t); m(1)=Rho(1)*V(1);
    Vt=-0.001*pi*6.25*2.413*w*sin(w*t*0.001)./V;  %dV/dt/V;
    B=sqrt(2)*0.85*Section_Area(height(t))/V0;
    for i=1:n-1
        if ismember(i,j)
            m(i)=m(1);
            P(i)=P(1);
            Rho(i)=Rho(1);
        end
        if P(i)>p(i)
            mt=-CA*sqrt((P(i)-p(i))*Rho(i))*h;
            m(i+1)=m(i)+mt;
            tmp1=-mt/V0-B(i)*sqrt(p(i)*rho(i))*h;
        else
            mt=0;
            m(i+1)=m(i);
            tmp1=-B(i)*sqrt(p(i)*rho(i))*h;
        end
        tmp=mt/V(i)-Rho(i)*Vt(i)*h;
        Rho(i+1)=Rho(i)+tmp;
        P(i+1)=P(i)+sc(P(i))*tmp/Rho(i);
        rho(i+1)=rho(i)+tmp1;
        p(i+1)=p(i)+sc(p(i))*tmp1/rho(i);
        if p(i+1)<0
            p(i+1)=0;
        end
    end
end