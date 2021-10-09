function x=Cramer(A,b)
%CRAMER   克莱姆法则求恰定线性方程组的解
% X=CRAMER(A,B)  克莱姆法则求线性方程组AX=B的解X
%
% 输入参数：
%     ---A：线性方程组的系数矩阵
%     ---B：线性方程组的右端向量
% 输出参数：
%     ---X：线性方程组的解
%
% See also det

[m,n]=size(A);
if m~=n || length(b)~=m
    error('线性方程组的系数矩阵和常数项维数不匹配.')
end
if isa([A,b(:)],'sym')
    x=sym(zeros(n,1));
else
    x=zeros(n,1);
end
D=det(A);
for k=1:n
    Dk=A;
    Dk(:,k)=b(:);
    Dk=det(Dk);
    x(k)=Dk/D;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html