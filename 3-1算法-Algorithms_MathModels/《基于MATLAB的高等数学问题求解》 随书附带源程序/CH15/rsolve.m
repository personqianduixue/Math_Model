function x=rsolve(F,G,u,x0)
%RSOLVE   z变换求解离散线性定常系统
% X=RSOLVE(F,G,U,X0)  求线性定常系统X(k+1)=F*X(k)+G*U(k)的解
%
% 输入参数：
%     ---F,G：系统的系数矩阵
%     ---U：系统输入
%     ---X0：系统的初始值
% 输出参数：
%     ---X：系统的解
%
% See also ztrans, iztrans

[m,n]=size(F);
[q,p]=size(G);
r=length(u);
if m~=n || n~=q
    error('系数矩阵维数不匹配.')
end
if isvector(u)
    if r~=p
        error('输入向量与控制矩阵维数不匹配.')
    end
end
I=sym(eye(size(F)));
syms z k
U=ztrans(sym(u));
x=simple(iztrans((z*I-sym(F))\(z*sym(x0)+sym(G)*U),z,k));
web -broswer http://www.ilovematlab.cn/forum-221-1.html