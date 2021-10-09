function P=PartialDerivative(fun,var,varargin)
%PARTIALDERIVATIVE   根据偏导数的定义求多元函数的偏导数
% P=PARTIALDERIVATIVE(FUN,VAR)  求函数FUN关于变量VAR的偏导数
% P=PARTIALDERIVATIVE(FUN,VAR,X,A,Y,B,...)  求函数FUN关于VAR的在
%                                           点(A,B,...)上的偏导数的值
% P=PARTIALDERIVATIVE(FUN,VAR,{'X=A','Y=B',...})  同上
%
% 输入参数：
%     ---FUN：多元符号函数
%     ---VAR：符号自变量
%     ---X,Y,...：函数的符号变量
%     ---A,B,...：函数的符号变量的值
% 输出参数：
%     ---P：返回的偏导数或偏导数的值
%
% See also diff, limit

h=sym('h','real');
s=symvar(fun);
if ~ismember(var,s)
    error('Symbols variables not designated.')
end
delta=subs(fun,var,sym(var+h))-fun;
P1=limit(delta/h,h,0);
if nargin==2
    P=P1;
elseif nargin==3
    x0=varargin{:};
    N=length(x0);
    if N>length(s)
        error('Too many Symbols variable-values.')
    end
    vars=cell(1,N);
    values=cell(1,N);
    for k=1:N
        kk=strfind(x0{k},'=');
        vars{k}=x0{k}(1:kk-1);
        values{k}=str2double(x0{k}(kk+1:end));
    end
    P=subs(P1,vars,values);
elseif nargin>3 && ~mod(nargin,2)
    vars=cell(1,nargin/2-1);
    values=cell(1,nargin/2-1);
    for k=1:length(varargin)/2
        vars{k}=varargin{2*k-1};
        values{k}=varargin{2*k};
    end
    P=subs(P1,vars,values);
else
    error('Illegal numbers of input arguments.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html