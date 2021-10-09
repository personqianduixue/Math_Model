% 灰色预测：一阶且只含一个变量
clc, clear

% 变量的存储向量
a = [390.6  412  320  559.2  380.8  542.4  553  310  561  300  632  540  406.2  313.8  576  587.6  318.5]';
% 灾变序列
t0 = find(a <= 320);
t1 = cumsum(t0);
n = length(t1);

% 计算
B = [-0.5 * (t1(1:end-1) + t1(2:end)), ones(n-1, 1)];
Y = t0(2:end);
r = B \ Y
y = dsolve('Dy+a*y=b', 'y(0)=y0');
y = subs(y, {'a', 'b', 'y0'}, {r(1), r(2), t1(1)});
predict1 = double(subs(y, 't', [0:n+1]))

predict = diff(predict1);
predict = [t0(1), predict]