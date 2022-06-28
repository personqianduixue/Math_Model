close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
k = 5;								
hilbert = zeros(k,k);     					%产生一个5×5全0矩阵
for m = 1:k							%应用for给Hilbert矩阵赋值
    for n = 1:k
        hilbert(m,n) = 1/(m+n -1);
    end
end
format rat
