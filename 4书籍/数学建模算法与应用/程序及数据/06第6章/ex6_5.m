clc,clear
syms t s
a=[1,0,0;2,1,-2;3,2,1];fs=[0;0;exp(s)*cos(2*s)];
x0=[0;1;1];
tx=int(expm(a*(t-s))*fs,s);  %先求不定积分
xstar=subs(tx,s,t)-subs(tx,s,0); %再求定积分，这样运行速度快
x=expm(a*t)*x0+xstar;
x=simple(x), pretty(x)
