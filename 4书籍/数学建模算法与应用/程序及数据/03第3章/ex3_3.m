clc, clear
syms x y
f=x^3-y^3+3*x^2+3*y^2-9*x;
df=jacobian(f);  %求一阶偏导数
d2f=jacobian(df); %求Hessian阵
[xx,yy]=solve(df)  %求驻点
xx=double(xx);yy=double(yy); %转化成双精度浮点型数据，下面判断特征值的正负，必须是数值型数据
for i=1:length(xx)
    a=subs(d2f,{x,y},{xx(i),yy(i)});  
    b=eig(a);  %求矩阵的特征值
    f=subs(f,{x,y},{xx(i),yy(i)});
    if all(b>0)
        fprintf('(%f,%f)是极小值点,对应的极小值为%f\n',xx(i),yy(i),f);
    elseif all(b<0)
        fprintf('(%f,%f)是极大值点,对应的极大值为%f\n',xx(i),yy(i),f);
    elseif any(b>0) & any(b<0)
        fprintf('(%f,%f)不是极值点\n',xx(i),yy(i));
    else
        fprintf('无法判断(%f,%f)是否是极值点\n',xx(i),yy(i));  
    end
end
