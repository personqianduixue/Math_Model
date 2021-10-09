syms x
y=x^3+6*x^2+8*x-1; dy=diff(y);
dy_zero=solve(dy), dy_zero_num=double(dy_zero)  %变成数值类型
ezplot(y)  %符号函数画图
