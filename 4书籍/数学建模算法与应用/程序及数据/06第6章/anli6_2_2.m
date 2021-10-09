clc,clear
syms m V rho g k t real
v=dsolve('m*Dv-m*g+rho*g*V+k*v^2','v(0)=0'); v=simple(v);
v=subs(v,{m,V,rho,g,k},{239.46,0.2058,1035.71,9.8,0.6});
v=simple(v); v=vpa(v,7)  %求速度函数系数的小数表达式
tt=solve(v-12.2)   %求时间的临界值T
s=int(v,0,tt)      %求位移的临界值
