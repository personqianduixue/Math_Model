function [x,minf]=minGN(f,x0,var,eps)
%目标函数：f
%初始点：x0
%自变量向量：var
%精度：eps
%目标函数最小值时的自变量值：x
%目标函数的最小值：minf

format long
if nargin==3
    eps=1.0e-6;
end
S=transpose(f)*f;   %目标函数S梯度表达式
k=length(f);
n=length(x0);
x0=transpose(x0);
tol=1;
A=jacobian(f,var);  %计算函数f的梯度

while tol>eps
    Fx=zeros(k,1);
    for i=1:k
        Fx(i,1)=Funval(f(i),var,x0);
    end
    Sx=Funval(S,var,x0);
    Ax=Funval(A,var,x0);
    gSx=transpose(Ax)*Fx;
    dx=-transpose(Ax)*Ax\gSx;
    x0=x0+dx;
    tol=norm(dx);
end
x=x0;
minf=Funval(S,var,x);
format short;