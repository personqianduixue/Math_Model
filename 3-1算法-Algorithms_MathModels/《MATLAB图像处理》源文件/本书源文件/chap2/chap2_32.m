close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=magic(3);
B=[1 2 3 4;5 6 7 8];
C=inv(A);									%求逆矩阵
D=pinv(B);								%求伪逆矩阵
