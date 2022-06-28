function y = average(x)
%求向量元素平均值.
%函数名为average，输入参数为一向量
%输入为非向量时报错
[m,n] = size(x);
if (~((m == 1) || (n == 1)) || (m == 1 && n == 1))
    error('Input must be a vector')
end
y = sum(x)/length(x);      
end
