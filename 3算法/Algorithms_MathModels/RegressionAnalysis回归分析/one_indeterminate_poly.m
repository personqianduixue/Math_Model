%% 一元多项式回归模型
% 选取 y = a2*x^2 + a1*x + a0
clc, clear

x0 = 17: 2: 29;
y0 = [20.48, 25.13, 26.15, 30.0, 26.1, 20.3, 19.35];

[p, s] = polyfit(x0, y0, 2);  % 2表示阶数
p                                              % p返回a2，a1，a0三个参数

% 求polyfit所得的回归多项式在x0处的预测值Y
%及预测值的显著性为1-alpha的置信区间DELTA；
%alpha缺省时为0.05。它假设polyfit函数数据输入的误差是独立正态的，并且方差为常数
[y, delta] = polyconf(p, x0, s);   % delta为置信区间半径

polytool(x0, y0, 2)