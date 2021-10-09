clc, clear
f=@(x) x(1)^3-x(2)^3+3*x(1)^2+3*x(2)^2-9*x(1);  %定义匿名函数
g=@(x) -f(x);
[xy1,z1]=fminunc(f, rand(2,1))  %求极小值点
[xy2,z2]=fminsearch(g,rand(2,1)); %求极大值点
xy2, z2=-z2
