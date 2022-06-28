close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=ones(2,4)*3;
B=rand(3,4);
C=[A;B];									%纵向合并两矩阵
D=[A B];									%横向合并两矩阵
