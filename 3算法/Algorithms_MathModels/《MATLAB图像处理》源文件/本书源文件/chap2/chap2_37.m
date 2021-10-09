close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=magic(5);							%产生5阶魔方矩阵A
a=A(1);								%查找A中最大元素，及元素下标
for i=2:25
    if A(i)>a
        a=A(i);
        n=i;
    end
end
