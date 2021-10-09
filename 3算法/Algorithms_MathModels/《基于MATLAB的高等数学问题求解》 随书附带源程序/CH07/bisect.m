function [x,fx,iter,X]=bisect(fun,a,b,eps,varargin)
%BISECT   二分法求方程的根
% X=BISECT(FUN,A,B)
% X=BISECT(FUN,A,B,EPS)
% X=BISECT(FUN,A,B,EPS,P1,P2,...)
% [X,FX]=BISECT(...)
% [X,FX,ITER]=BISECT(...)
% [X,FX,ITER,XS]=BISECT(...)
%
% 输入参数：
%     ---FUN：方程的函数描述，可以为匿名函数、内联函数或M文件形式
%     ---A,B：区间端点
%     ---EPS：精度设定
%     ---P1,P2,...：方程的附加参数
% 输出参数：
%     ---X：返回的方程的根
%     ---FX：方程根对应的函数值
%     ---ITER：迭代次数
%     ---XS：迭代根序列
%
% See also fzero, RootInterval

if nargin<3
    error('输入参数至少需要3个！')
end
if nargin<4 || isempty(eps)
    eps=1e-6;
end
fa=feval(fun,a,varargin{:});
fb=feval(fun,b,varargin{:});
% fa=fun(a,varargin{:});fb=fun(b,varargin{:});
k=1;
if fa*fb>0  % 不满足二分法使用条件
    warning(['区间[',num2str(a),',',num2str(b),']内可能没有根']);
elseif fa==0  % 区间左端点为根
    x=a; fx=fa;
elseif fb==0  % 区间右端点为根
    x=b; fx=fb;
else
    while abs(b-a)>eps;  % 控制二分法结束条件
        x=(a+b)/2;  % 二分区间端点
        fx=feval(fun,x,varargin{:}); % 计算中点的函数值
        if fa*fx>0;  % 条件
            a=x;   % 端点更新
            fa=fx;  % 端点函数值更新
        elseif fb*fx>0;  % 条件
            b=x;  % 端点更新
            fb=fx;  % 端点函数值更新
        else
            break
        end
        X(k)=x;
        k=k+1;
    end
end
iter=k;
web -broswer http://www.ilovematlab.cn/forum-221-1.html