function I=quad_inf(fun,a,b,tol,eps)
%QUAD_INF   无穷限反常积分的无穷区间逼近法
% I=QUAD_INF(FUN,A,B)  求函数FUN在区间[A,B]上的数值积分，A或B可以为无穷，下同
% I=QUAD_INF(FUN,A,B,TOL)  求函数FUN在区间[A,B]上的数值积分，容差为TOL
% I=QUAD_INF(FUN,A,B,TOL,EPS)  求无穷限反常积分，精度为EPS
%
% 输入参数：
%     ---FUN：被积函数
%     ---A,B：积分区间的端点，要求A<B
%     ---TOL：容差，缺省值为1e-6
%     ---EPS：精度要求，迭代终止准则，缺省值为1e-5
% 输出参数：
%     ---I：求得的积分值
%
% See also quadgk, quadl

if nargin<5 || isempty(eps)
    eps=1e-5;
end;
if nargin<4 || isempty(tol)
    tol=1e-6;
end;
N=2;I=0;T=1;
if isinf(a) && isinf(b)
    I=quad_inf(fun,-inf,0)+quad_inf(fun,0,inf);  % 递归调用
elseif isinf(b)
    while T>eps
        b=a+N;
        T=quadl(fun,a,b,tol);
        I=I+T;
        a=b; N=2*N;
    end
elseif isinf(a)
    while T>eps
        a=b-N;
        T=quadl(fun,a,b,tol);
        I=I+T;
        b=a; N=2*N;
    end
else
    I=quadl(fun,a,b,tol);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html