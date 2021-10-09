function xi=IntermediateTheorem(fun,range,C)
%INTERMEDIATETHEOREM   验证连续函数的介值定理
% IntermediateTheorem(FUN,RANGE,C)  以图形的形式验证连续函数在闭区间上的介值定理
% XI=IntermediateTheorem(FUN,RANGE,C)  返回连续函数的一个介值点，但不绘制图形
%
% 输入参数：
%     ---FUN：连续函数的表达式
%     ---RANGE：指定的区间[a,b]
%     ---C：介于FUN(a)与FUN(b)的任意实数
% 输出参数：
%     ---XI：XI满足FUN(XI)=C，若为指定输出则以图形方式验证
%
% See also fzero

if nargin==2
    C=0;
end
fab=feval(fun,range);
if prod(fab-C)<=0  % 判断C是否属于f(a)和f(b)之间
    if fab(1)==0
        x0=range(1);
    elseif fab(2)==0
        x0=range(2);
    else
        x0=fzero(@(x)fun(x)-C,range);
    end
else
    return
end
if nargout==1  % 判断输出参数个数
    xi=x0;
else
    fplot(fun,range)
    hold on
    plot(xlim,[C,C],'k--')
    plot(x0,fun(x0),'k*')
    title(['\xi=',num2str(x0)])
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html