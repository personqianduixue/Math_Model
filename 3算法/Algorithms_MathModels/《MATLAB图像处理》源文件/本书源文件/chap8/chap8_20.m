
clear all; close all;
A=[1 1 1 1; 2 2 2 2; 3 3 3 3]
s=size(A);
M=s(1);
N=s(2);
P=dctmtx(M)
Q=dctmtx(N)
B=P*A*Q'

