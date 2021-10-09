function [x,minf]=minMixFun(f,g,h,x0,r0,c,var,eps)
%目标函数：f
%不等式约束：g
%等式约束：h
%初始点：x0
%罚因子：r0
%缩小系数：c
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量的值：x
%目标函数的最小值：minf

gx0=Funval(g,var,x0);
if gx0>=0
    ;
else
    disp('初始点必须满足不等式约束！');          %初始点检查
    x=NaN;
    minf=NaN;
    return;
end

if c>=1||c<0
    disp('缩小系数必须大于0且小于1！');         %缩小检查系数
    x=NaN;
    minf=NaN;
    return;
end

if nargin==7
    eps=1.0e-6;
end

FE=0;
for i=1:length(g)
    FE=FE+1/g(i);
end
FH=transpose(h)*h;

x1=transpose(x0);
x2=inf;

while 1
    FF=r0*FE+FH/sqrt(r0);                   %构造增广目标函数
    SumF=f+FF;
    [x2,minf]=minNT(SumF,transpose(x1),var);    %用牛顿法求解无约束规划
    
    if norm(x2-x1)<=eps                         %精度判断
        x=x2;
        break;
    else
        r0=c*r0;
        x1=x2;
    end
end
min=Funval(f,var,x);