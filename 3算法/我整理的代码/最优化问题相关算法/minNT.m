function [x,minf]=minNT(f,x0,var,eps)
%目标函数：f
%初始点：x0
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量值：x;
%目标函数的最小值：minf

format long;
if nargin==3
    eps=1.0e-6;
end
tol=1;
x0=transpose(x0);
while tol>eps           
    gradf=jacobian(f,var);      %梯度方向
    jacf=jacobian(gradf,var);   %雅克比矩阵
    v=Funval(gradf,var,x0);
    tol=norm(v);
    pv=Funval(jacf,var,x0);
    p=-inv(pv)*transpose(v);    %搜索方向
    x1=x0+p;
    x0=x1;
end

x=x1;
minf=Funval(f,var,x);
format short;