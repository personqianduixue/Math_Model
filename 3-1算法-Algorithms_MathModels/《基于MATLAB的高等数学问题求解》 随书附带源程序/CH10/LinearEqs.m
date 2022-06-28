function [x,e]=LinearEqs(A,b)
%LINEAREQS   线性方程组的求解
% X=LINEAREQS(A,B)  利用MATLAB自带函数求线性方程组AX=B的解X
% [X,E]=LINEAREQS(A,B)  求线性方程组的解X并返回其误差
%
% 输入参数：
%     ---A：方程组的系数矩阵
%     ---B：方程组的右端向量
% 输出参数：
%     ---X：方程组的解
%     ---E：解的误差
%
% See also null, inv(\), pinv

[m,n]=size(A);b=b(:);
if m~=length(b);
    error('系数矩阵A和右端向量b维数不匹配.')
end
r1=rank(A);r2=rank([A b]);
if ~all(b)  % 齐次线性方程组
    if r1==n
        x=zeros(size(b));
    else
        z=null(sym(A));   %解出规范化的化零空间
        k=sym('k%d',[n-r1,1]);   %定义各基础解系对应的系数
        x=z*k;   %原方程的通解
    end
else  % 非齐次线性方程组
    if r1==r2&&r1==n
        disp('方程组是恰定的，有唯一解！')
        x=A\b;
    elseif r1==r2&&r1~=n
        disp('方程组是欠定的，有无穷解！')
        warning off all
        z=null(sym(A));   %解出规范化的化零空间
        x0=sym(A)\b;  %求出一个特解
        k=sym('k%d',[n-r1,1]);   %定义各基础解系对应的系数
        x=x0+z*k;   %原方程的通解
    else
        disp('方程组是超定的，只有最小二乘意义下的解！')
        x=pinv(A)*b;
    end
end
e=norm(double(A*x-b));
web -broswer http://www.ilovematlab.cn/forum-221-1.html