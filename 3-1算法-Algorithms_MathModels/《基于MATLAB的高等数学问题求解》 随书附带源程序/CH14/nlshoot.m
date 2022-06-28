function [t,y] = nlshoot(f1,fv,tspan,x0f,tol,varargin)
%NLSHOOT   非线性边值问题的打靶法求解
% [T,Y] = NLSHOOT(F1,FV,TSPAN,X0F,TOL)  打靶法求非线性边值问题F1的解
% [T,Y] = NLSHOOT(F1,FV,TSPAN,X0F,TOL,P1,P2,...)  打靶法求非线性边值问题F1的解，
%                                              其中F1，FV包含附加参数P1,P2,...
%
% 输入参数：
%     ---F1,FV：微分方程与前面介绍的关于变量v1,v2,v3,v4的微分方程的函数描述
%     ---TSPAN：求解区间
%     ---X0F：给定的边值条件
%     ---TOL：精度要求，用于控制参数m的误差
%     ---P1,P2,...：函数F1和FV的附加参数
% 输出参数：
%     ---T：返回的节点
%     ---Y：边值问题的解
%
% See also ode45, lineshoot

m0=1;  % m的初值
err=1;
while abs(err)>tol;
    [~,v] = ode45(fv,tspan,[x0f(1);m0;0;1],varargin);  % 计算迭代式
    m=m0-(v(end,1)-x0f(2))/v(end,3);  % 更新m的数值
    err=m-m0;
    m0=m;
end
[t,y] = ode45(f1,tspan,[x0f(1);m],varargin);  % 利用得到的初值求解方程
web -broswer http://www.ilovematlab.cn/forum-221-1.html