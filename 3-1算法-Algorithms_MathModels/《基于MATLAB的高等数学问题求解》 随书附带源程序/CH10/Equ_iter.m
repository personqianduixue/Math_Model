function [x,iter,exitflag]=Equ_iter(varargin)
%EQU_ITER   迭代法求线性方程组的解
% X=EQU_ITER(A,B,'jacobi')  雅克比迭代法求线性方程组AX=B的解X，初始迭代点X0、
%                           精度EPS和最大迭代次数ITER_MAX均取默认值
% X=EQU_ITER(A,B,X0,EPS,ITER_MAX,'jacobi')  雅克比迭代法求线性方程组AX=B的解X
% [X,ITER]=EQU_ITER(...)  雅克比迭代法求线性方程组的解并返回迭代次数
% [X,ITER,EXITFLAG]=EQU_ITER(...)  雅克比迭代法求线性方程组的解并返回迭代次数和成功标志
% X=EQU_ITER(A,B,'seidel')  高斯赛德尔方法求线性方程组AX=B的解X，初始迭代点X0、
%                           精度EPS和最大迭代次数ITER_MAX均取默认值
% X=EQU_ITER(A,B,X0,EPS,ITER_MAX,'seidel')  高斯赛德尔方法求线性方程组AX=B的解X
% [X,ITER]=EQU_ITER(...,'seidel')  高斯赛德尔方法求线性方程组AX=B的解X并返回迭代次数
% [X,ITER,EXITFLAG]=EQU_ITER(...,'seidel')  高斯赛德尔方法求线性方程组AX=B的解X，
%                                           并返回迭代次数和成功标志
% X=EQU_ITER(A,B,W,'sor')  SOR方法求线性方程组AX=B的解X，初始迭代点X0、
%                          精度EPS和最大迭代次数ITER_MAX均取默认值
% X=EQU_ITER(A,B,W,X0,EPS,ITER_MAX,'sor')  SOR方法求线性方程组AX=B的解X
% [X,ITER]=EQU_ITER(...,'sor')  SOR方法求线性方程组AX=B的解X并返回迭代次数
% [X,ITER,EXITFLAG]=EQU_ITER(...,'sor')  SOR方法求线性方程组AX=B的解X，
%                                        并返回迭代次数和成功标志
%
% 输入参数：
%     ---A：线性方程组的系数矩阵
%     ---B：线性方程组的右端项
%     ---W：超松弛因子
%     ---X0：初始向量，默认值为零向量
%     ---EPS：精度要求，默认值为1e-6
%     ---ITER_MAX：最大迭代次数，默认值为100
%     ---TYPE：迭代方法类型，TYPE有以下几种取值：
%              1.'jacobi'或1：雅克比迭代法
%              2.'seidel'或2：高斯赛德尔迭代法
%              3.'sor'或3：SOR迭代法
% 输出参数：
%     ---X：线性方程组的近似解
%     ---ITER：迭代次数
%     ---EXITFLAG：迭代成功与否的标志：1表示迭代成功，0表示迭代失败
% 
% See also Gauss

args=varargin;
style=args{end};
A=args{1};
b=args{2};
[m,n]=size(A);
if m~=n || length(b)~=m
    error('线性方程组的系数矩阵和常数项维数不匹配.')
end
iter=0;
exitflag=1;
D=diag(diag(A));
L=tril(A,-1);
U=triu(A,1);
switch lower(style)
    case {1,'jacobi'}  % Jacobi迭代法
        if nargin==3
            x0=zeros(n,1);
            eps=1e-6;
            iter_max=100;
        elseif nargin==6
            [x0,eps,iter_max]=deal(args{3:5});
        else
            error('输入参数个数有误.')
        end
        J=-inv(D)*(L+U);f=D\b;
        while iter<iter_max
            x=J*x0+f;
            if norm(x-x0,inf)<eps
                break
            end
            x0=x;iter=iter+1;
        end
    case {2,'seidel'}  % Gauss-Seidel迭代法
        if nargin==3
            x0=zeros(n,1);
            eps=1e-6;
            iter_max=100;
        elseif nargin==6
            [x0,eps,iter_max]=deal(args{3:5});
        else
            error('输入参数个数有误.')
        end
        G=-inv(D+L)*U;f_G=(D+L)\b;
        while iter<iter_max
            x=G*x0+f_G;
            if norm(x-x0,inf)<eps
                break
            end
            x0=x;iter=iter+1;
        end
    case {3,'sor'}  % SOR迭代法
        w=args{3};
        if nargin==4
            x0=zeros(n,1);
            eps=1e-6;
            iter_max=100;
        elseif nargin==7
            [x0,eps,iter_max]=deal(args{4:6});
        else
            error('输入参数个数有误.')
        end
        S=(D+w*L)\((1-w)*D-w*U);f_w=w*((D+w*L)\b);
        while iter<iter_max
            x=S*x0+f_w;
            if norm(x-x0,inf)<eps
                break
            end
            x0=x;iter=iter+1;
        end
    otherwise
        error('Illegal options.')
end
if iter==iter_max
    exitflag=0;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html