format rat
a=[1,1,0;1,0,1;1,1,1;1,2,-1];
b=[1;2;0;-1];
x1=a\b    %这里\和pinv是等价的
x2=pinv(a)*b
format  %恢复到短小数的显示格式
