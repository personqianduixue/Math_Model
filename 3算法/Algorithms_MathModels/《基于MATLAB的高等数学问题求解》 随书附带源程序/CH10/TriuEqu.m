function x=TriuEqu(U,b)
%TRIUEQU   消去法求上三角方程组的解
% X=TRIUEQU(U,B)  消去法求方程组UX=B的解，其中U是上三角阵
%
% 输入参数：
%     ---U：线性方程组的系数矩阵，是一个上三角矩阵
%     ---B：线性方程组的右端向量
% 输出参数：
%     ---X：线性方程组的解
%
% See also Cramer

[m,n]=size(U);
if m~=n || length(b)~=m
    error('线性方程组的系数矩阵和常数项维数不匹配.')
end
if isa([U,b(:)],'sym')
    x=sym(zeros(n,1));
else
    x=zeros(n,1);
end
x(n)=b(n)/U(n,n);  % 求x_n
for k=n-1:-1:1
    x(k)=(b(k)-U(k,k+1:n)*x(k+1:n))/U(k,k);  % 求x_k，k=n-1,n-2,…,1
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html