function varargout=SeparableVarsDE(F,G,x,y,varargin)
%SEPARABLEVARSDE   可分离变量方程的求解
% L=SEPARABLEVARSDE(F,G,X,Y)  求微分方程G(Y)dY=F(X)dX的通解
% L=SEPARABLEVARSDE(F,G,X,Y,COND)  求微分方程G(Y)dY=F(X)dX满足条件COND的特解
%
% 输入参数：
%     ---F,G：关于X和Y的函数
%     ---X,Y：函数F和G的自变量
%     ---COND：初值条件
% 输出参数：
%     ---L：微分方程的解
%
% See also int, solve

Iy=int(F,x);
Ix=int(G,y);
syms C real
I=Iy-Ix-C;
if nargin==4
    varargout{1}=[char(I),'=0'];
elseif nargin==5
    cond=varargin{:};
    k1=strfind(cond,'(');
    k2=strfind(cond,')');
    k3=strfind(cond,'=');
    x0=sym(cond(k1(1)+1:k2(1)-1));
    y0=sym(cond(k3+1:end));
    C1=solve(subs(I,{x,y},{x0,y0}),C);
    varargout{1}=[char(subs(I,C,C1)),'=0'];
else
    error('Illegal input arguments.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html