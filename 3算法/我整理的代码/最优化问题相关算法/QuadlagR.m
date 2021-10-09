function [xv,fv]=QuadlagR(H,c,A,b)
%正定矩阵：H
%二次规划一次项系数向量：c
%等式约束矩阵：A
%等式约束右端向量：b
%目标函数取最小值时的自变量值：xv
%目标函数的最小值：fv

invH=inv(H);
F=invH*transpose(A)*inv(A*invH*transpose(A))*A*invH-invH;
D=inv(A*invH*transpose(A))*A*invH;
xv=F*c+transpose(D)*b;
fv=transpose(xv)*H*xv/2+transpose(c)*xv;