close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A = [0 1 1 0 1];
B = [1 1 0 0 1];
C=A&B;								%与运算
D=A|B;								%或运算
E=~A;								%非运算
F=and(A,B);							%and函数与运算
G=xor(A,B);							%异或运算
