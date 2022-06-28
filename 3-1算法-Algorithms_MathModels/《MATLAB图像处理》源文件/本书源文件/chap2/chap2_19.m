close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=eye(3);								%建立3×3对角矩阵A
B=magic(3);							%建立3×3魔方矩阵B
C1=A.*B;								%A点乘B
C2=A*B;								%A乘以B
C3=A/B;								%A左除B
C4=A./B;								%A左点除B
