function [x,y]=Explicit_Euler(odefun,xspan,y0,h,varargin)
%EXPLICIT_EULER   欧拉法求解初值问题的数值解
% [X,Y]=EXPLICIT_EULER(ODEFUN,XSPAN,Y0,H)  欧拉法求微分方程ODEFUN的数值解
% [X,Y]=EXPLICIT_EULER(ODEFUN,XSPAN,Y0,H,P1,P2,...)  欧拉法求微分方程ODEFUN
%                                      的数值解，ODEFUN含有附加参数P1,P2,...
%
% 输入参数：
%     ---ODEFUN：微分方程的函数描述
%     ---XSPAN：求解区间[x0,xn]
%     ---Y0：初始条件
%     ---H：迭代步长
%     ---P1,P2,...：ODEFUN函数的附加参数
% 输出参数：
%     ---X：返回的节点，即X=XSPAN(1):H:XSPAN(2)
%     ---Y：微分方程的数值解
%
% See also ode*

x=xspan(1):h:xspan(2);
N=length(x);
y=zeros(1,N);
y(1)=y0;
for k=1:N-1
    y(k+1)=y(k)+h*feval(odefun,x(k),y(k),varargin{:});
end
x=x';y=y';
web -broswer http://www.ilovematlab.cn/forum-221-1.html