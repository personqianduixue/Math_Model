function g=test3(x);
M=50000;
f=x(1)^2+x(2)^2+8;
g=f-M*min(min(x),0)-M*min(x(1)^2-x(2),0)+M*(-x(1)-x(2)^2+2)^2;
