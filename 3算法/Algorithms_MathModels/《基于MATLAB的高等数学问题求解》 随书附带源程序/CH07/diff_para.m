function result=diff_para(y,x,t,n)
%DIFF_PARA   参数方程求导
% R=DIFF_PARA(Y,X)或R=DIFF_PARA(Y,X,[])  当符号表达式X只含有一个符号变量时，
%                                                求由X和Y决定的参数方程的导数dY/dX
% R=DIFF_PARA(Y,X,T)  求由X和Y决定的参数方程关于自变量T的导数dY/dX
% R=DIFF_PARA(Y,X,T,N)  求由X和Y决定的参数方程关于自变量T的N阶导数dNY/dXN
%
% 输入参数：
%     ---Y,X：参数方程的符号表达式
%     ---T：参数方程的符号自变量
%     ---N：求导阶次
% 输出参数：
%     ---R：参数方程求导结果
%
% See also diff

if nargin<4
    n=1;
end
if nargin==2 || isempty(t)
    t=symvar(x);
    if length(t)>1
        error('The Symbolic variable not point out.')
    end
end
if n==1
    result=diff(y,t)/diff(x,t);
else
    result=diff(diff_para(y,x,t,n-1),t)/diff(x,t);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html