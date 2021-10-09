function [A,B,F] = fseriesquadl(fun,x,n,a,b)
%FSERIESQUADL   傅里叶级数的数值求解
% [A,B,F]=FSERIESQUADL(FUN,X,N)  求函数FUN在区间[-pi,pi]上的N阶数值傅里叶展式
% [A,B,F]=FSERIESQUADL(FUN,X,N,ALPHA,BETA)  求函数FUN在指定区间上的数值傅里叶展式
%
% 输入参数：
%     ---FUN：给定的待展开函数
%     ---X：自变量数据
%     ---N：展开项数
%     ---ALPHA,BETA：级数展开区间，默认值为[-pi,pi]
% 输出参数：
%     ---A,B：傅里叶系数向量
%     ---F：函数的傅里叶展开式在X上的值
%
% See also quadl, fseriessym

if nargin==3
    a=-pi;b=pi; 
end
L=(b-a)/2;
f=inline(fun);
var=char(argnames(f));
A=zeros(1,n+1);B=zeros(1,n);
A(1) = quadl(f,-L,L)/L; % 计算A_0
F=A(1)/2;
for k=1:n;
    fcos=inline(['(',fun,')','.*cos(',num2str(k*pi/L),'*',var,')']); 
    fsin=inline(['(',fun,')','.*sin(',num2str(k*pi/L),'*',var,')']); 
    A(k+1) =quadl(fcos,-L,L)/L;  % 计算系数A(2:n+1)
    B(k)=quadl(fsin,-L,L)/L;  % 计算系数B(1:n)
    F=F+A(k+1)*cos(k*pi*x/L)+B(k)*sin(k*pi*x/L);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html