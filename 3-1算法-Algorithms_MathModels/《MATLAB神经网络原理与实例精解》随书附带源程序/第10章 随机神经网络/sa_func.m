function y = sa_func (x)
% 函数 y = 5 * sin(x1 * x2) + x1 ^2 + x2 ^2;
% 用于模拟退火算法试验

if length(x)<2,
    y= 0;
    return;
end

x1= x(1);
x2= x(2);

y = 5*sin(x1.*x2)+x1.^2+x2.^2;
