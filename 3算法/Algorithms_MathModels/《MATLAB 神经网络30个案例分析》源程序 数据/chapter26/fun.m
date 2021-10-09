function y = fun(x)
%函数用于计算粒子适应度值
%x           input           输入粒子 
%y           output          粒子适应度值 

y=-20*exp(-0.2*sqrt((x(1)^2+x(2)^2)/2))-exp((cos(2*pi*x(1))+cos(2*pi*x(2)))/2)+20+exp(1);

%y=x(1)^2-10*cos(2*pi*x(1))+10+x(2)^2-10*cos(2*pi*x(2))+10;

