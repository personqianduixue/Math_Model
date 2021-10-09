function [X,FVAL,TYPE]=Extremum(fun,range)
%EXTREMUM   求函数在指定区间上的极值点及极值
% X=EXTREMUM(FUN,RANGE)
% [X,FVAL]=EXTREMUM(...)
% [X,FVAL,TYPE]=EXTREMUM(...)
%
% 输入参数：
%     ---FUN：函数的符号表达式
%     ---RANGE：求值区间
% 输出参数：
%     ---X：极值点
%     ---FVAL：极值
%     ---TYPE：极值类型描述
%
% See also diff, solve

x=sym('x','real');
s=symvar(fun);
if length(s)>1
    error('函数fun必须只包含一个符号变量.')
end
if ~isequal(x,s)
    fun=subs(fun,s,x);
end
df=diff(fun);
x0=unique(double(solve(df)));
d2f=diff(df);
N=length(x0);
X=[];
for kk=1:N
    if prod(x0(kk)-range)<=0
        X=[X,x0(kk)];
    end
end
FVAL=subs(fun,X);
D=subs(d2f,X);
TYPE=cell(1,N);
for k=1:N
    if D(k)==0
        TYPE{k}='不确定';
    elseif D(k)>0
        TYPE{k}='极小值';
    else
        TYPE{k}='极大值';
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html