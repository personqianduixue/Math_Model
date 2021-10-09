function [x,minf]=minMGN(f,x0,var,eps)
%目标函数：f
%初始点：x0
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量值：x
%目标函数的最小值：minf
format long
if nargin==3
    eps=1.0e-6;
end
S=transpose(f)*f;           %函数S的梯度
k=length(f);
n=length(x0);
x0=transpose(x0);
tol=1;
A=jacobian(f,var);          %函数f的梯度

while tol>eps
    Fx=zeros(k,1);
    for i=1:k
        Fx(i,1)=Funval(f(i),var,x0);
    end
    Sx=Funval(S,var,x0);
    Ax=Funval(A,var,x0);
    gSx=transpose(Ax)*Fx;       %函数S当前的梯度值
    
    dx=-transpose(Ax)*Ax\gSx;   %自变量增量
    alpha=1;
    while 1
        S1=Funval(S,var,x0+alpha*dx);
        S2=Sx+2*(1.0e-5)*alpha*transpose(dx)*gSx;
        if S1>S2
            alpha=alpha/2;      %参数修正
            continue;
        else
            break;
        end
    end
    x0=x0+alpha*dx;
    tol=norm(dx);
end
x=x0;
minf=Funval(S,var,x);
format short;
