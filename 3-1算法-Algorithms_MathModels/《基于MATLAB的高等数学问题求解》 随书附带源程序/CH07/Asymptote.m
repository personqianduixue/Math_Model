function equation=Asymptote(fun,varargin)
%ASYMPTOTE   求曲线的渐近线
% EQUATION=ASYMPTOTE(FUN,H)  求曲线的水平渐近线，H可以为1,'h','hor'或'horizontal'
% EQUATION=ASYMPTOTE(FUN,V,X0)  求曲线的垂直渐近线，V可以为2,'v','ver'或'vertical'
% EQUATION=ASYMPTOTE(FUN,L)  求曲线的斜渐近线，L可以为3,'l'或'lean'
%
% 输入参数：
%     ---FUN：曲线方程的函数形式
%     ---X0：垂直渐近线方程X=X0
%     ---H,V,L：指定渐近线的类型，H表示水平渐近线；V表示垂直渐近线；L表示斜渐近线
% 输出参数：
%     ---EQUATION：渐近线的方程，若不存在，则返回字符串'不存在'
%
% See also limit

type=varargin{1};
x=sym('x','real');
s=symvar(fun);
if length(s)>1
    error('函数fun必须只包含一个符号变量.')
end
if ~isequal(x,s)
    fun=subs(fun,s,x);
end
switch lower(type)
    case {1,'h','hor','horizontal'}  % 水平渐近线
        k=limit(fun,x,inf);
        if isinf(double(k))
            equation='不存在';
        else
            equation=char(['y=',char(k)]);
        end
    case {2,'v','ver','vertical'}  % 垂直渐近线
        x0=varargin{2};
        if isempty(x0) || nargin==2
            equation='不存在';
        else
            N=length(x0);
            equation=cell(1,N);
            for k=1:N
                if ~isinf(double(limit(fun,x,x0(k),'right'))) &&...
                        ~isinf(double(limit(fun,x,x0(k),'left')))
                    equation{k}='不存在';
                else
                    equation{k}=char(['x=',char(sym(x0(k)))]);
                end
            end
        end
    case {3,'l','lean'}  % 斜渐近线
        K=limit(fun/x,x,inf);
        b=limit(fun-K*x,inf);
        if isinf(double(K)) || isequal(K,0)
            equation='不存在';
        else
            equation=char(['y=',char(K),'*x+',char(b)]);
        end
    otherwise
        error('Illegal options.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html