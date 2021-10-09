function [x,fval,iter,exitflag]=Newtons(fun,x0,eps,maxiter)
%NEWTONS   牛顿法求非线性方程组的根
% X=NEWTONS(FUN,X0)  牛顿法求非线性方程组的解，初始迭代点为X0
% X=NEWTONS(FUN,X0,EPS)  牛顿法求非线性方程组的解，精度要求为EPS
% X=NEWTONS(FUN,X0,EPS,MAXITER)  牛顿法求非线性方程组的解，最大迭代次数为MAXITER
% [X,FVAL]=NEWTONS(...)  牛顿法求非线性方程组的解并返回解处的函数值
% [X,FVAL,ITER]=NEWTONS(...)  牛顿法求非线性方程组的解并返回迭代次数
% [X,FVAL,ITER,EXITFLAG]=NEWTONS(...)  牛顿法求非线性方程组的解并返回迭代成功标志
%
% 输入参数：
%     ---FUN：非线性方程组的符号表达式
%     ---X0：初始迭代点向量
%     ---EPS：精度要求，默认值为1e-6
%     ---MAXITER：最大迭代次数，默认值为1e4
% 输出参数：
%     ---X：非线性方程的近似解向量
%     ---FVAL：解处的函数值
%     ---ITER：迭代次数
%     ---EXITFLAG：迭代成功标志，1表示成功，0表示失败
%
% See also newton

if nargin<2
    error('输入参数至少需要2个.')
end
if nargin<3
    eps=1e-6;
end
if nargin<4
    maxiter=1e4;
end
if isa(fun,'inline')
    fun=char(fun);
    k=strfind(fun,'.');
    fun(k)=[];
    fun=sym(fun);
elseif ~isa(fun,'sym')
    error('函数类型必须是内联函数或符号函数.')
end
s=symvar(fun);
if length(s)>length(x0)
    error('函数的自由变量过多.')
end
x0=x0(:);
J=jacobian(fun,s);
k=0;err=1;
exitflag=1;
while err>eps
    k=k+1;
    fx0=subs(fun,num2cell(s),num2cell(x0));
    J0=subs(J,num2cell(s),num2cell(x0));
    x1=x0-J0\fx0;
    err=norm(x1-x0);
    x0=x1;
    if k>=maxiter
        exitflag=0;
        break
    end
end
x=x1;
fval=fx0;
iter=k;
web -broswer http://www.ilovematlab.cn/forum-221-1.html