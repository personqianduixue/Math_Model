function [x,minf]=minFactor(f,x0,h,v,M,alpha,gama,var,eps)
%目标函数：f
%初始点：x0
%约束函数：g
%初始乘子向量：v
%罚因子：M
%放大系数：alpha
%参数：gama
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量值：x
%目标函数的最小值：minf

format long;
if nargin==8
    eps=1.0e-4;
end
FE=0;
for i=1:length(h)
    FE=h(i)^2;
end
x1=transpose(x0);
x2=inf;

while 1
    FF=M*FE/2;
    Fh=v*h;
    SumF=f+FF-Fh;    %乘子法的罚函数
    [x2,minf]=minNT(SumF,transpose(x1),var);    %用牛顿法进行一维搜索
    
    Hx2=Funval(h,var,x2);
    Hx1=Funval(h,var,x1);
    if norm(Hx2)<eps                            %精度判断
        x=x2;
        break;
    else
        if Hx2/Hx1>=gama
            M=alpha*M;                          %修正罚因子
            x1=x2;
        else
            v=v-M*transpose(Hx2);               %修正乘子向量
            x1=x2;
        end
    end
end
minf=Funval(f,var,x);
format short;