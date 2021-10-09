function [g f]=fun(x)

h=75;
r=50;
x1=-3;
n=10;
w=50/n;
xn=-sqrt(50^2-w^2);
g=[ %1*r-h*tan(x(2))
   %h*tan(x(2))-1.3*r
   h*x(1)*tan(x(2))-sqrt(r^2-(r/2)^2)
  r-h/cos(x(2))*x(1)-x1
  sqrt(((-h*x(1)/cos(x(2))*sin(x(2))+x1)-xn)^2+(-h*x(1))^2)-xn-h/cos(x(2))+x1
  ];
f=[];