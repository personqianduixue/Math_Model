function T=taylor_diff(fx,n,x,x0)
%TAYLOR_DIFF   根据泰勒公式的定义式求函数的泰勒展开式
% T=TAYLOR_DIFF(F)
% T=TAYLOR_DIFF(F,N)
% T=TAYLOR_DIFF(F,N,X)
% T=TAYLOR_DIFF(F,N,X,X0)
%
% 输入参数：
%     ---F：函数的符号表达式
%     ---N：泰勒展开式的阶次
%     ---X：符号自变量
%     ---X0：泰勒展开点
% 输出参数：
%     ---T：返回的泰勒展开式
%
% See also diff, limit

if nargin<4
    x0=0;
end
if nargin<3
    x=symvar(fx);
    if length(x)>1
        error('The Symbolic variable not point out.')
    end
end
if nargin<2
    n=6;
end
a=cell(1,n);
T=limit(fx,x,x0);
for k=2:n
    a{k}=1/sym(factorial(k-1))*limit(diff(fx,x,k-1),x,x0);
    T=T+a{k}*(x-x0)^(k-1);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html