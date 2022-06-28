function [ yhat ] = func( beta, x )
%FUNC 适用于非线性回归的模型函数
%   此处显示详细说明
yhat = (beta(4) * x(:, 2) - x(:, 3) / beta(5)) ./ (1 + beta(1) * x(:, 1)+ ...
    beta(2) * x(:, 2) + beta(3) * x(:, 3));

end

