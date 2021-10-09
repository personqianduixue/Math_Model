global w h a W x lamda;
w=2.5;h=60-3;a=1;W=60;lamda=5;  
x=[2.5:2.5:30]';
%8xing,  gaiwei: 
%w=2.5;h=70-3;a=1;W=90;lamda=5;  
%x=[2.5:2.5:45]';
ts0=[pi/4,h/2];
lb=[0,0];
ub=[pi/2,h];
ts=fmincon(@objfun,ts0,[],[],[],[],lb,ub,@confun)

confun.m:
function [c,ceq]=confun(ts)
%ts=[theta,s];

global w h a W x lamda;
l=w+h/sin(ts(1));
d=l-ts(2);
q=32.5-abs(x);             %8xing,  gaiwei:    q=sqrt(30^2-(x-15)^2);
len=sqrt(d^2-+w^2+q^2-2*(d*cos(ts(1))+w)*q+2*d*w*cos(ts(1)))+q-d-w;

c=[a*W-2*(w+h*cot(ts(1)));
    -(q+(d*cos(ts(1))+w-q).*(l-q)./sqrt(d^2-+w^2+r^2-x.^2-2*(d*cos(ts(1))+w)*q+2*d*w*cos(ts(1))));
    len-ts(2)+lamda
    ];
ceq=[];

objfun.m
function f=objfun(ts)
f=-sin(ts(1));
%di er mubiao
%l=w+h/sin(ts(1));
%d=l-ts(2);
%q=32.5-abs(x);  
%len=sqrt(d^2-+w^2+q^2-2*(d*cos(ts(1))+w)*q+2*d*w*cos(ts(1)))+q-d-w
%f=sum(len);
