function [x,U]=Gauss(A,b)
%GAUSS   高斯消去法求线性方程组的解
% X=GAUSS(A,B)  高斯消去法求线性方程组AX=B的解X
% [X,U]=GAUSS(A,B)  高斯消去法求线性方程组AX=B的解X并返回消元后的上三角方程组的增广矩阵
%
% 输入参数：
%     ---A：线性方程组的系数矩阵
%     ---B：线性方程组的右端项
% 输出参数：
%     ---X：线性方程组的解
%     ---U：消元后的上三角方程组的增广矩阵
%
% See also TriuEqu

[m,n]=size(A);
if m~=n || length(b)~=m
    error('线性方程组的系数矩阵和常数项维数不匹配.')
end
% 消元过程
for k=1:n-1
    m=A(k+1:n,k)/A(k,k);
    A(k+1:n,k+1:n)=A(k+1:n,k+1:n)-m*A(k,k+1:n);
    b(k+1:n)=b(k+1:n)-m*b(k);
    if isa([A,b(:)],'sym')
        A(k+1:n,k)=sym(zeros(n-k,1));
    else
        A(k+1:n,k)=zeros(n-k,1);
    end
end
U=[A,b];
x=TriuEqu(A,b);
web -broswer http://www.ilovematlab.cn/forum-221-1.html