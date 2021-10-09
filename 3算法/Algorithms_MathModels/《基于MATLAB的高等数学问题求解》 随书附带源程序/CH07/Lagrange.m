function xi=Lagrange(fun,range)
%LAGRANGE   验证函数在某个区间上是否满足拉格朗日中值定理
% LAGRANGE(FUN,RANGE)  以图形的方式演示函数在某个区间上的拉格朗日中值定理
% XI=LAGRANGE(FUN,RANGE)  返回函数在指定区间上的一个拉格朗日中值点
%
% 输入参数：
%     ---FUN：函数的MATLAB描述，可以是匿名函数、内联函数和M文件
%     ---RANGE：指定的区间
% 输出参数：
%     ---XI：拉格朗日中值点
%
% Sea also Rolle

fab=subs(fun,range);
df=diff(fun);
while 1
    x=fzero(inline(df-diff(fab)/diff(range)),rand);
    if prod(x-range)<=0
        break
    end
end
if nargout==1
    xi=x;
else
    ezplot(fun,range)
    hold on
    x_range=[x-diff(range)/10,x+diff(range)/10];
    y_range=diff(fab)/diff(range)*(x_range-x)+subs(fun,x);
    plot(x_range,y_range,'k--')
    title(['\xi=',num2str(x)])
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html