function [x,minf]=minLM(f,x0,beta,u,v,var,eps)
%目标函数：f
%初始点：x0
%参数：beta
%阻尼参数：u
%放大系数：v
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量值：x
%目标函数的最小值：minf

format long;
if nargin==6
    eps=1.0e-6;
end
S=transpose(f)*f;
k=length(f);
n=length(x0);
x0=transpose(x0);
A=jacobian(f,var);          %函数f的梯度
tol=1;

while tol>eps
    Fx=zeros(k,1);
    for i=1:k
        Fx(i,1)=Funval(f(i),var,x0);
    end
    Sx=Funval(S,var,x0);
    Ax=Funval(A,var,x0);
    gSx=transpose(Ax)*Fx;   %函数S的梯度
    Q=transpose(Ax)*Ax;
    
    while 1
        dx=-(Q+u*eye(size(Q)))\gSx; %自变量增量
        
        x1=x0+dx;
        for i=1:k
            Fx1(i,1)=Funval(f(i),var,x1);
        end
        Sx1=Funval(S,var,x1);
        tol=norm(dx);               %验证终止条件是否满足
        if tol<=eps
            break;
        end
        
        if Sx1>=Sx+beta*transpose(gSx)*dx
            u=v*u;
            continue;
        else
            u=u/v;
            break;
        end
    end
    x0=x1;
end
x=x0;
minf=Funval(S,var,x);
format short
    