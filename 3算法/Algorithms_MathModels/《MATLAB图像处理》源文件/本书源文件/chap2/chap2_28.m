close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=eye(3);								
B=rand(3);
C1=repmat(A,2,3);						%将矩阵复制合并成新矩阵
C2=blkdiag(A,B);						%将矩阵合并成对角矩阵
