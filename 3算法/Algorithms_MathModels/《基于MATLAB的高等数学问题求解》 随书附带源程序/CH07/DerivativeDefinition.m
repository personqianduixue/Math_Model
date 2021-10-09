function df=DerivativeDefinition(fun,x,x0,type)
%DERIVATIVEDEFINITION   根据导数的定义求函数的导函数或在某点处导数值
% DF=DERIVATIVEDEFINITION(FUN,X)或
% DF=DERIVATIVEDEFINITION(FUN,X,[])  求函数FUN关于X的导函数
% DF=DERIVATIVEDEFINITION(FUN,X,X0)  求函数FUN在点X0处的导函数
% DF=DERIVATIVEDEFINITION(FUN,X,X0,TYPE)  根据TYPE指定导数类型求函数在点X0处的导数，
%                                                 TYPE有以下取值：
%                                                 1.'double'或0：双侧导数值，此为缺省值
%                                                 2.'left'或-1：左导数
%                                                 3.'right'或1：右导数
% DF=DERIVATIVEDEFINITION(FUN,X,[],TYPE)  根据TYPE指定导数类型求函数的导函数
%
% 输入参数：
%     ---FUN：符号函数表达式
%     ---X：符号自变量
%     ---X0：求导点
%     ---TYPE：导数类型
% 输出参数：
%     ---DF：返回的导函数或导数值
%
% See also limit, diff

if nargin<4
    type=0;
end
if nargin==2 || isempty(x0)
    x0=x;
end
syms h
delta_y=subs(fun,x,x0+h)-subs(fun,x,x0);
switch type
    case {0,'double'}
        df=limit(delta_y/h,h,0);  % 求导数
    case {-1,'left'}
        df=limit(delta_y/h,h,0,'left');  % 求左导数
    case {1,'right'}
        df=limit(delta_y/h,h,0,'right');  % 求右导数
    otherwise
        error('The Style of Derivative is Illegal.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html