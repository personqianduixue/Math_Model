syms t
a=[2,1,3;0,2,-1;0,0,2];
x0=[1;2;1];
x=expm(a*t)*x0, pretty(x)
