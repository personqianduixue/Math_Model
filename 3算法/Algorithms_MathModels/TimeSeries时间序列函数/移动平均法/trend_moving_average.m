%% 趋势移动平均法
% 在一次移动平均的基础上再做一次移动平均
clc, clear

y = [676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107];

% 第一次移动平均
m1 = length(y);
n = 6;    % 移动平均的项数
for i = 1:m1-n+1
    yhat1(i) = sum(y(i:i+n-1))/n;
end

% 第二次移动平均
m2 = length(yhat1);
for i = 1:m2-n+1
    yhat2(i) = sum(yhat1(i:i+n-1))/n;
end

plot(1:m1, y, '*');
% 计算平滑系数
at = 2*yhat1(end) - yhat2(end);
bt = 2*(yhat1(end)-yhat2(end)) / (n-1);

% 预测后两个数值
y_predict1 = at + bt;
y_predict2 = at + 2*bt;