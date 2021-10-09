function [Interval,type,Inflexion]=Concavity(varargin)
%CONCAVITY   求函数在指定区域上的凹凸区间及拐点
% [INTERVAL,TYPE,INFLEXION]=CONCAVITY(FUN,DOMAIN)  求函数FUN在区间DOMAIN上的
%                                   凹凸区间和拐点以及各凹凸区间上曲线的凹凸性
% [INTERVAL,TYPE,INFLEXION]=CONCAVITY(FUN,DOMAIN,X0)  求函数FUN在区间DOMAIN上
%         的凹凸区间和拐点以及各凹凸区间上曲线的凹凸性，其中二阶导数无定义点已知
%
% 输入参数：
%     ---FUN：函数表达式
%     ---DOMAIN：指定区间
% 输出参数：
%     ---INTERVAL：凹凸区间
%     ---TYPE：各凹凸区间上曲线的凹凸性
%     ---INFLEXION：拐点
%
% See also solve, diff, Monotonicity

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
df=diff(fun,2);
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
Inflexion=[];
if ~isequal(domain(1),x(1))
    Interval{1}=[domain(1),x(1)];
    if isinf(domain(1))
        f1=realfunvalue(df,x(1)-0.1);
    else
        f1=realfunvalue(df,(domain(1)+x(1))/2);
    end
    type{1}=Judgment(f1,{'凸弧','凹弧'});
else
    Interval{1}=[];
    type{1}=[];
end
for k=2:N
    Interval{k}=[x(k-1),x(k)];
    f=realfunvalue(df,sum(x([k-1,k]))/2);
    type{k}=Judgment(f,{'凸弧','凹弧'});
end
if ~isequal(x(end),domain(2))
    Interval{end}=[x(end),domain(2)];
    if isinf(domain(2))
        f2=realfunvalue(df,x(N)+0.1);
    else
        f2=realfunvalue(df,(x(N)+domain(2))/2);
    end
    type{N+1}=Judgment(f2,{'凸弧','凹弧'});
else
    Interval{N+1}=[];
    type{N+1}=[];
end
for k=2:N+1
    if all(strcmp(type(k-1:k),{'凹弧','凸弧'})) ||...
            all(strcmp(type(k-1:k),{'凸弧','凹弧'}))
        Inflexion=[Inflexion,x(k-1)];
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html