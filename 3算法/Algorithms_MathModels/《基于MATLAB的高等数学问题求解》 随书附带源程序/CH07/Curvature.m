function K=Curvature(varargin)
%CURVATURE   求函数的曲率
% K=CURVATURE(FUN,X)
% K=CURVATURE(FUNX,FUNY,T)
%
% 输入参数：
%     ---FUN：函数的一般方程
%     ---FUNX,FUNY：函数的参数方程
%     ---X,T：函数的符号自变量
% 输出参数：
%     ---K：曲率
%
% See also diff

args=varargin;
if nargin==2
    fun=args{1}; x=args{2};
    df=diff(fun,x);
    d2f=diff(df,x);
    K=abs(d2f)/(1+df^2)^(3/2);
elseif nargin==3
    funx=args{1}; funy=args{2}; t=args{3};
    dx=diff(funx,t);
    d2x=diff(dx,t);
    dy=diff(funy,t);
    d2y=diff(dy,t);
    K=abs(dx*d2y-dy*d2x)/(dx^2+dy^2)^(3/2);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html