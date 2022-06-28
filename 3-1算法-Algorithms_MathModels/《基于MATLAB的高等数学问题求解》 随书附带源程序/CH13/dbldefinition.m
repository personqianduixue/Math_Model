function I=dbldefinition(fun,D,m,n)
%DBLDEFINITION   根据二重积分的定义计算二重积分
% I=DBLDEFINITION(FUN,D,M)  计算函数FUN在区域D上的二重积分，D分为M*M部分
% I=DBLDEFINITION(FUN,D,M,N)  计算函数FUN在区域D上的二重积分，D分为M*N部分
%
% 输入参数：
%     ---FUN：二元函数的MATLAB描述，可以是匿名函数或内联函数等
%     ---D：积分区域
%     ---M,N：积分区域的划分数
% 输出参数：
%     ---I：二重积分值
%
% See also sum, diff

if nargin<4
    n=m;
end
a=min(D(1,:));
b=max(D(1,:));
c=min(D(2,:));
d=max(D(2,:));
x=linspace(a,b,m);
y=linspace(c,d,n);
[X,Y]=meshgrid(x,y);
in=inpolygon(X(:),Y(:),D(1,:),D(2,:));
f=fun(X(in),Y(in));
I=sum(f*diff(x(1:2))*diff(y(1:2)));
web -broswer http://www.ilovematlab.cn/forum-221-1.html