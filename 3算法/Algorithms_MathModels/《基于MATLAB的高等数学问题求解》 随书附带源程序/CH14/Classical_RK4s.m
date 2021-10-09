function [x,y]=Classical_RK4s(odefun,xspan,y0,h,varargin)
%CLASSICAL_RK4S   经典Runge-Kutta法求解常微分方程组
% [X,Y]=CLASSICAL_RK4S(ODEFUN,XSPAN,Y0,H)  经典四阶Runge-Kutta法求解微分方程组ODEFUN
% [X,Y]=CLASSICAL_RK4S(ODEFUN,XSPAN,Y0,H,P1,P2,...)  经典四阶Runge-Kutta法求解
%                                 微分方程组ODEFUN，ODEFUN包含附加参数P1,P2,...
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
% See also Explicit_Euler, Classical_RK4, ode*

x=xspan(1):h:xspan(2);
y(:,1)=y0(:);
for k=1:length(x)-1
    K1=feval(odefun,x(k),y(:,k),varargin{:});
    K2=feval(odefun,x(k)+h/2,y(:,k)+h/2*K1,varargin{:});
    K3=feval(odefun,x(k)+h/2,y(:,k)+h/2*K2,varargin{:});
    K4=feval(odefun,x(k)+h,y(:,k)+h*K3,varargin{:});
    y(:,k+1)=y(:,k)+h/6*(K1+2*K2+2*K3+K4);
end
x=x';y=y';
web -broswer http://www.ilovematlab.cn/forum-221-1.html