function y = fun(x)
%函数用于计算粒子适应度值
%x           input           输入粒子 
%y           output          粒子适应度值 
y=sin( sqrt(x(1).^2+x(2).^2) )./sqrt(x(1).^2+x(2).^2)+exp((cos(2*pi*x(1))+cos(2*pi*x(2)))/2)-2.71289;



