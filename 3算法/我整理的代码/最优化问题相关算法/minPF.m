function [x,minf]=minPF(f,x0,A,b,c1,p,var,eps)
%这里设计到了牛顿法的相关源码
%目标函数：f
%初始点：x0
%约束矩阵：A
%约束右端向量：b
%罚参数的初始常数：c1
%罚参数的比例系数：p
%自变量向量：var
%精度：eps
%目标函数取最小值的自变量的值：x
%目标函数的最小值：minf

format long;
if nargin==7
    eps=1.0e-4;
end
k=0;
FE=0;
for i=1:length(b)
    FE=FE+(var*transpose(A(1,:))-b(i))^2;   %构造罚函数
end
x1=transpose(x0);
x2=inf;

while 1
    M=c1*p;
    FF=M*FE;
    SumF=f+FF;
    [x2,minf]=minNT(SumF,transpose(x1),var);    %用牛顿法求解无约束规划
    if norm(x2-x1)<=eps                         %精度判断
        x=x2;
        break;
    else
        c1=M;
        x1=x2;
    end
end
minf=Funval(f,var,x);
format short;