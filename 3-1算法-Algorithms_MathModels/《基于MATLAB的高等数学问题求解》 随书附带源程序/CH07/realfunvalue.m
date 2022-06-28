function y=realfunvalue(fun,x)
%REALFUNVALUE   在复数范围内求函数在某点处的实函数值
% Y=REALFUNVALUE(FUN,X)  在复数范围内求函数FUN在X处的实函数值
%
% 输入参数：
%     ---FUN：函数的符号表达式
%     ---X：指定的自变量值
% 输出参数：
%     ---Y：返回的实函数值
%
% See also finverse, solve

warning off all
F=subs(fun,x);
if ~isreal(F)
    t=symvar(fun);
    t=sym(t,'real');
    f=finverse(fun);
    y=solve(f-x,t);
else
    y=F;
end
y=double(y);
web -broswer http://www.ilovematlab.cn/forum-221-1.html