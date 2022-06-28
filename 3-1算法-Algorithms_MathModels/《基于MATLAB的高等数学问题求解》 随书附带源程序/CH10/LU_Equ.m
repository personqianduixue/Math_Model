function [x,L,U]=LU_Equ(A,b)
%LU_EQU   LU分解法求线性方程组的解
% X=LU_EQU(A,B)  LU分解法求线性方程组AX=B的解X
% [X,L,U]=LU_EQU(A,B)  LU分解法求线性方程组AX=B的解X，并返回分解后的上(下)三角矩阵
%
% 输入参数：
%     ---A：线性方程组的系数矩阵
%     ---B：线性方程组的右端项
% 输出参数：
%     ---X：线性方程组的解
%     ---L：分解后的下三角矩阵
%     ---U：分解后的上三角矩阵
%
% See also TriuEqu

[m,n]=size(A);
if m~=n || length(b)~=m
    error('线性方程组的系数矩阵和常数项维数不匹配.')
end
if isa([A,b(:)],'sym')
    U=sym(zeros(n));
    L=sym(eye(n));
else
    U=zeros(n);
    L=eye(n);
end
U(1,:)=A(1,:);
L(2:n,1)=A(2:n,1)/U(1,1);
for k=2:n
    U(k,k:n)=A(k,k:n)-L(k,1:k-1)*U(1:k-1,k:n);
    L(k+1:n,k)=A(k+1:n,k)-L(k+1:n,1:k-1)*U(1:k-1,k);
    L(k+1:n,k)=L(k+1:n,k)/U(k,k);
end
y=flipud(TriuEqu(rot90(L,2),flipud(b(:))));
x=TriuEqu(U,y);
web -broswer http://www.ilovematlab.cn/forum-221-1.html