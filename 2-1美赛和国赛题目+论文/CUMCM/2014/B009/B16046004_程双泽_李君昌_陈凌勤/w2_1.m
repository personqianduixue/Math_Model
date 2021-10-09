global w h a W r x lamda;
w=2.5;h=70-3;a=1;W=80;lamda=1.5;r=sqrt(40*40+2.5*2.5);
x=[2.5:2.5:40]';
ts0=[pi/4,h/2];
lb=[0,0];
ub=[pi/2,h];
ts=fmincon(@objfun,ts0,[],[],[],[],lb,ub,@confun)
