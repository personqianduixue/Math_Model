close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=[0 0 1;2 0 0;0 3 0];
B=logical(A); 					%将矩阵A转换成逻辑矩阵B
C=true(3);						%生成3阶逻辑真矩阵
D=false(3);						%生成3阶逻辑假矩阵
