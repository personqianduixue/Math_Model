function [t,y] = lineshoot(f1,f2,tspan,x0f,varargin)
%LINESHOOT   线性边值问题的打靶法求解
% [T,Y] = LINESHOOT(F1,F2,TSPAN,X0F)  打靶法求线性边值问题F1的解
% [T,Y] = LINESHOOT(F1,F2,TSPAN,X0F,P1,P2,...)  打靶法求线性边值问题F1的解，其中
%                                               F1和F2包含附加参数P1,P2,...
%
% 输入参数：
%     ---F1,F2：微分方程及其对应齐次方程的函数描述
%     ---TSPAN：求解区间
%     ---X0F：边值条件
%     ---P1,P2,...：函数F1和F2的附加参数
% 输出参数：
%     ---T：返回的节点
%     ---Y：边值问题的解
%
% See also ode45

[~,y1] = ode45(f2,tspan,[1;0],varargin);  % 计算函数y_1(t)
[~,y2] = ode45(f2,tspan,[0;1],varargin);  % 计算函数y_2(t)
[~,yp] = ode45(f1,tspan,[0;0],varargin);  % 计算函数y_p(t)
m = (x0f(2)-x0f(1)*y1(end,1)-yp(end,1))/y2(end,1);  % 求参数m
[t,y] = ode45(f1,tspan,[x0f(1);m],varargin);  % 求出原微分方程的解
web -broswer http://www.ilovematlab.cn/forum-221-1.html