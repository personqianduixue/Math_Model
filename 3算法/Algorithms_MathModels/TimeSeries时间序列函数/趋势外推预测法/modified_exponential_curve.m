%% 修正指数曲线法
clc, clear
global a1 b1 K1

yt = [42.1 47.5 52.7 57.7 62.5 67.1 71.5 75.7 79.8 ...
      83.7 87.5 91.1 94.6 97.9 101.1];
n = length(yt);
m = n/3;   % 将时间序列的n个观测值等分为三部分，采用三合法确定K的值
cf = diff(yt);
for i = 1:n-2
    bzh(i) = cf(i+1)/cf(i);
end
range = minmax(bzh);
s1 = sum(yt(1:m));
s2 = sum(yt(m+1:2*m));
s3 = sum(yt(2*m+1:end));

b1 = (s3-s2)/(s2-s1)^(1/m);
a1 = (s2-s1)*(b-1)/(b*(b^m-1)^2);
K1 = (s1-a*b*(b^m-1)/(b-1))/m;
y = predict1(1:18);    % 显示预测的18个数值（3个是无监督的）

plot(1:15, yt, '*', 1:18, y)