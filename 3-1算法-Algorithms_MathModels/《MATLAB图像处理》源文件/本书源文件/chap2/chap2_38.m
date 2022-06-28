close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
k=5;
for m = 1:k							%创建一个5阶方阵A，当行标和列标相等的元素赋2，
    for n = 1:k							%行标和列标的差的绝对值为2的元素赋1
        if m == n
            a(m,n) = 2;
        elseif abs(m-n) == 2
            a(m,n) = 1;
        else
            a(m,n) = 0;
        end
    end
end
