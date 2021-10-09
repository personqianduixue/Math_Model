function varargout=Rolle(fun,range)
%ROLLE   验证函数在某个区间上是否满足罗尔定理
% ROLLE(FUN,RANGE)  以图形的方式演示函数在某个区间上的罗尔定理
% TF=ROLLE(FUN,RANGE)  以图形的方式演示函数在某个区间伤的罗尔定理，
%                          并返回表征函数是否满足罗尔定理的量，TF=1满足；TF=0不满足
% [TF,XI]=ROLLE(FUN,RANGE)  返回表征函数在指定区间上是否满足罗尔定理的量TF和一个罗尔点
%
% 输入参数：
%     ---FUN：函数的MATLAB描述，可以是匿名函数、内联函数和M文件
%     ---RANGE：指定的区间
% 输出参数：
%     ---TF：表征是否满足罗尔定理的量
%     ---XI：罗尔点
%
% See also fzero

fab=subs(fun,range);
tf=0;
if fab(1)~=fab(2)
    disp('函数fun在区间range上不满足罗尔定理.')
    return
else
    tf=1;
end
df=diff(fun);
while 1
    xi=fzero(inline(df),rand);
    if prod(xi-range)<=0
        break
    end
end
if nargout==2 && tf==1
    varargout{1}=tf;
    varargout{2}=xi;
else
    varargout{1}=tf;
    ezplot(fun,range)
    hold on
    plot([xi-diff(range)/10,xi+diff(range)/10],[0,0],'k--')
    title(['\xi=',num2str(xi)])
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html