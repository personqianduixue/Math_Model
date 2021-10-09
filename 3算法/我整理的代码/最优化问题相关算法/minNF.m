function [x,minf]=minNF(f,x0,g,u,v,var,eps)
%目标函数：f
%初始点：x0
%约束函数：g
%罚因子：u
%缩小系数：v
%自变量向量：var
%精度：eps
%目标函数取最小值时自变量的值：x
%目标函数的最小值：minf

format long;
if nargin==6;
    eps=1.0e-4;
end
k=0;
FE=0;
for i=1:length(g)
    FE=FE+1/g(i);               %构造罚函数
end
x1=transpose(x0);
x2=inf;

while 1
    FF=u*FE;
    SumF=f+FF;
    [x2,minf]=minNT(SumF,transpose(x1),var);    %用牛顿法求解无约束规划
    Bx=Funval(FE,var,x2);
    if u*Bx<eps
        if norm(x2-x1)<=eps
            x=x2;
            break;
        else
            u=v*u;                              %参数修正
            x1=x2;
        end
    else
        if norm(x2-x1)<=eps
            x=x2;
            break;
        else
            u=v*u;
            x1=x2;
        end
    end
end
minf=Funval(f,var,x);
format short;