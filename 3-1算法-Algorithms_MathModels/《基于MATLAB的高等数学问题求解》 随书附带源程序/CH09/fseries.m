function [A,B,F,type]=fseries(f,x,n,a,b)
%FSERIES   傅里叶级数求解，并返回傅里叶级数的类型
% [A,B,F]=FSERIES(FUN,X,N)  求奇(或偶)函数FUN在区间[-pi,pi]上的N阶傅里叶展式
% [A,B,F]=FSERIES(FUN,X,N,ALPHA,BETA)  求奇(或偶)函数FUN在指定区间上的N阶傅里叶展式
% [A,B,F,TYPE]=FSERIES(...)  求函数的傅里叶展式并返回傅里叶级数类型
%
% 输入参数：
%     ---FUN：给定的待展开函数
%     ---X：自变量
%     ---N：展开项数
%     ---ALPHA,BETA：级数展开区间，默认值为[-pi,pi]
% 输出参数：
%     ---A,B：傅里叶系数向量
%     ---F：函数的傅里叶展开式
%     ---TYPE：傅里叶级数类型字符串
%
% See also int, fseriessym, fseriesquadl

if nargin==3
    a=-pi;b=pi;
end
L=(b-a)/2;
f1=subs(f,-x);
A=sym(zeros(1,n+1));
B=sym(zeros(1,n));
F=0;
if isequal(simple(f+f1),0)  % 奇函数
    for k=1:n
        B(k)=2*int(f*sin(k*pi*x/L),x,0,L)/L;
        F=F+B(k)*sin(k*pi*x/L);
    end
    type='正弦级数';
elseif isequal(f,f1)  % 偶函数
    for k=0:n
        A(k+1)=2*int(f*cos(k*pi*x/L),x,0,L)/L;
        F=F+A(k+1)*cos(k*pi*x/L);
    end
    type='余弦级数';
else  % 一般函数
    A(1)=int(f,x,-L,L)/L;
    F=A(1)/2;
    for k=1:n
        A(k+1)=int(f*cos(k*pi*x/L),x,-L,L)/L;
        B(k)=int(f*sin(k*pi*x/L),x,-L,L)/L;
        F=F+A(k+1)*cos(k*pi*x/L)+B(k)*sin(k*pi*x/L);
    end
    type='一般三角级数';
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html