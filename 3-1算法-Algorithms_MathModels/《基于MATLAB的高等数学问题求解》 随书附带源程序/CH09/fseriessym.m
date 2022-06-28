function [A,B,F]=fseriessym(f,x,n,a,b)
%FSERIESSYM   傅里叶级数的符号求解
% [A,B,F]=FSERIESSYM(FUN,X,N)  将函数FUN在区间[-pi,pi]上展成N阶傅里叶级数
% [A,B,F]=FSERIESSYM(FUN,X,N,ALPHA,BETA)  将函数FUN在指定区间上展成N阶傅里叶级数
%
% 输入参数：
%     ---FUN：给定的待展开函数
%     ---X：自变量
%     ---N：展开项数
%     ---ALPHA,BETA：级数展开区间，默认值为[-pi,pi]
% 输出参数：
%     ---A,B：傅里叶系数向量
%     ---F：函数的傅里叶展开式
%
% See also int

if nargin==3
    a=-pi;b=pi; 
end
L=(b-a)/2; 
A=int(f,x,-L,L)/L;
B=[];F=A/2;
for k=1:n
   ak=int(f*cos(k*pi*x/L),x,-L,L)/L;
   bk=int(f*sin(k*pi*x/L),x,-L,L)/L;
   A=[A,ak];
   B=[B,bk];
   F=F+ak*cos(k*pi*x/L)+bk*sin(k*pi*x/L);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html