function y = fun(x)
%函数用于计算粒子适应度值
%x           input           输入粒子 
%y           output          粒子适应度值 

y=1/4000.*( x(1).^2+x(2).^2 )-cos( x(1)./1 ).*cos( x(2)./sqrt(2) )+1;


