function [x,fx,iter,X]=newton(fun,x0,eps,maxiter)
%NEWTON   牛顿法求方程的根
% X=NEWTON(FUN,X0)  牛顿法求方程在初始点X0处的根
% X=NEWTON(FUN,X0,EPS)  牛顿法求方程在初始点X0处的精度为EPS的根
% X=NEWTON(FUN,X0,EPS,MAXITER)  牛顿法求方程的根并设定最大迭代次数
% [X,FX]=NEWTON(...)  牛顿法求根，并返回根处的函数值
% [X,FX,ITER]=NEWTON(...)  牛顿法求根并返回根处的函数值以及迭代次数
% [X,FX,ITER,XS]=NEWTON(...)  牛顿法求根并返回根处的函数值、迭代次数以及迭代根序列
%
% 输入参数：
%     ---FUN：方程的函数描述，可以为匿名函数、内联函数或M文件形式
%     ---X0：初始迭代点
%     ---EPS：精度设定
%     ---MAXITER：最大迭代次数
% 输出参数：
%     ---X：返回的方程的根
%     ---FX：方程根对应的函数值
%     ---ITER：迭代次数
%     ---XS：迭代根序列
%
% See also fzero, RootInterval, bisect

if nargin<2
    error('输入参数至少需要2个！')
end
if nargin<3 || isempty(eps)
    eps=1e-6;
end
if nargin<4 || isempty(maxiter)
    maxiter=1e4;
end
s=symvar(fun);
if length(s)>1
    error('函数fun必须只包含一个符号变量.')
end
df=diff(fun,s);
k=0;err=1;
while abs(err)>eps
    k=k+1;
    fx0=subs(fun,s,x0);
    dfx0=subs(df,s,x0);
    if dfx0==0
        error('f(x)在x0处的导数为0，停止计算')
    end
    x1=x0-fx0/dfx0;
    err=x1-x0;
    x0=x1;
    X(k)=x1;
end
if k>=maxiter
    error('迭代次数超限，迭代失败！')
end
x=x1;fx=subs(fun,x);iter=k;X=X';
web -broswer http://www.ilovematlab.cn/forum-221-1.html