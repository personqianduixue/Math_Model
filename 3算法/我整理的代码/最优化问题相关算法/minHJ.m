function [x,minf]=minHJ(f,a,b,eps)
%目标函数：f
%极值区间左端点：a
%极值区间右端点：b
%精度：eps
%目标函数取最小值时自变量的值：x
%目标函数所取的最小值：minf

format long;
if nargin==3
    eps=1.0e-6;
end

l=a+0.382*(b-a);            %试探点
u=a+0.618*(b-a);            %试探点
k=1;
tol=b-a;

while tol>eps&&k<100000
    fl=subs(f,symvar(f),l);        %试探点函数值
    fu=subs(f,symvar(f),u);        %试探点函数值
    if fl>fu
        a=1;                        %改变区间左端点
        l=u;
        u=a+0.618*(b-a);            %缩短搜索区间
    else
        b=u;                        %改变区间右端点
        u=l;
        l=a+0.382*(b-a);             %缩短搜索区间
    end
    k=k+1;
    tol=abs(b-a);
end
if k==100000
    disp('找不到最小值！');
    x=NaN;
    minf=NaN;
    return;
end
x=(a+b)/2;
minf=subs(f,symvar(f),x);
format short;