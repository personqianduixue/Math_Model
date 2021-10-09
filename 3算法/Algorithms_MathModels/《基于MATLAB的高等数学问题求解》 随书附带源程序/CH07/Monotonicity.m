function [Interval,type]=Monotonicity(varargin)
%MONOTONICITY   求函数在指定区域上的单调区间及单调性
% [INTERVAL,TYPE]=MONOTONICITY(FUN,DOMAIN)  求函数FUN在区间DOMAIN上的单调区间
% [INTERVAL,TYPE]=MONOTONICITY(FUN,DOMAIN,X0)  求函数FUN在区间DOMAIN上的单调
%                      区间，其中函数FUN一阶导数的没有定义的点（极点除外）已知
%
% 输入参数：
%     ---FUN：函数表达式
%     ---DOMAIN：指定的区间
%     ---X0：一阶导数的没有定义的点（极点除外）
% 输出参数：
%     ---INTERVAL：返回的单调区间
%     ---TYPE：各单调区间上函数的单调性
%
% See also solve, diff

warning off all
[fun,domain]=deal(varargin{1:2});
x=sym('x','real');
s=symvar(fun);
if length(s)>1
    error('函数fun必须只包含一个符号变量.')
end
if ~isequal(x,s)
    fun=subs(fun,s,x);
end
df=diff(fun);
[num,den]=numden(df);
xd=solve(den);
xd=double(xd);
x=solve(num);
x=double(x);
x=unique([xd(:);x(:)]);
if nargin==3
    x0=varargin{3};
    x=unique([x;x0(:)]);
end
N=length(x);
Interval=cell(1,N+1);
type=cell(1,N+1);
if ~isequal(domain(1),x(1))
    Interval{1}=[domain(1),x(1)];
    if isinf(domain(1))
        f1=realfunvalue(df,x(1)-0.1);
    else
        f1=realfunvalue(df,(domain(1)+x(1))/2);
    end
    type{1}=Judgment(f1,{'单调减少','单调增加'});
else
    Interval{1}=[];
    type{1}=[];
end
for k=2:N
    Interval{k}=[x(k-1),x(k)];
    f=realfunvalue(df,sum(x([k-1,k]))/2);
    type{k}=Judgment(f,{'单调减少','单调增加'});
end
if ~isequal(x(end),domain(2))
    Interval{end}=[x(end),domain(2)];
    if isinf(domain(2))
        f2=realfunvalue(df,x(N)+0.1);
    else
        f2=realfunvalue(df,(x(N)+domain(2))/2);
    end
    type{N+1}=Judgment(f2,{'单调减少','单调增加'});
else
    Interval{N+1}=[];
    type{N+1}=[];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html