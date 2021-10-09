function [x,minf]=minGeneralPF(f,x0,h,c1,p,var,eps)
%该函数是针对一般等式都生效的=。=
%初始点：x0;
%等式约束函数：h
%罚参数的初始常数：c1
%罚参数的比例系数：p
%自变量向量：var
%精度：eps
%目标函数去最小值时的自变量的值：x
%目标函数的最小值：minf

format long
if nargin==6
    eps=1.0e-4;
end
k=0;
FE=0;
for i=1:length(h)
    FE=FE+(h(i))^2;         %构造罚函数
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