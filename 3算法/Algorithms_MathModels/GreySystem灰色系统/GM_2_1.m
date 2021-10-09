%% GM(2,1)模型
% 与Verhulst模型的适用范围相同
clc, clear
% 原始数据倘若增长过快，需要进行弱化处理！
x0 = [41, 49, 61, 78, 96, 104];
n = length(x0);
x1 = cumsum(x0);
a_x0 = [0, diff(x0)];
for i = 2:n
    z(i) = 0.5 * (x1(i) + x1(i-1))
end

B = [-x0(2:end)', -z(2:end)', ones(n-1, 1)];
Y = a_x0(2:end)';
u = B \ Y
x = dsolve('D2x+a1*Dx+a2*x=b', 'x(0) = c1, x(5) = c2');
x = subs(x, {'a1', 'a2', 'b', 'c1', 'c2'}, {u(1), u(2), u(3), x1(1), x1(6)});
predict_1 = double(subs(x, 't', 0:n-1));
predict = [predict_1(1), diff(predict_1)]

epsilon = x0 - predict
delta = abs(epsilon ./ x0)