%% simulated_annealing
% 模拟退火算法：适用于寻找全局最小值的优化问题

clc, clear

load example_1.txt
data = example_1;

x = data(:, 1:2:8); x = x(:);
y = data(:, 2:2:8); y = y(:);
[n, m] = size(data);         % 返回数据的行数和列数(主要是需要行数)
n = n * 4;                           % 每一行4个数据，一共有4n个点（再加上始末， 一共4n+2个点）

data = [x y];
d1 = [70, 40];
data = [d1; data; d1];     % 始点与终点
data = data * pi / 180;   % 从角度制转化为弧度制

distance = zeros(n+2);  % 建立距离矩阵
for i = 1:n+1
    for j = i + 1:n+2
        tmp = cos(data(i, 1) - data(j, 1)) * cos(data(i, 2)) * cos(data(j, 2)) + ...
        sin(data(i, 2)) * sin(data(j, 2));
        distance(i, j) = 6370 * acos(tmp);
    end
end

distance = distance + distance';
S0 = [ ]; 
sum = inf;   % 看实际数据情况修改为一个较大的数字

% 使用蒙特卡洛模拟求得一个初始解
rand('twister',5489);
for j = 1:1000
    S = [1, 1+randperm(n), n+2];            % 长度为n+2的向量：第一位是1，中间是2到n+1的随机序列，最后一位是n+2
    tmp = 0;
    for i = 1:n+1
        tmp = tmp + distance(S(i), S(i+1));
    end
    if tmp < sum
        S0 = S; sum = tmp;
    end
end

% 设定初始值
e = 0.1^30;       % 终止温度
L = 20000;         % 循环次数
alpha = 0.999;  % 降温系数
T = 1;                  % 初始温度

% 退火过程
for k = 1:L
    % 产生新解
    c = 2 + floor(n * rand(1, 2));   % 随机产生一个(2, n+2)之间的随机整数
    c = sort(c);
    c1 = c(1); c2 = c(2);
    % 计算函数代价
    delta = distance(S0(c1-1), S0(c2)) + distance(S0(c1), S0(c2+1)) - ...
    distance(S0(c1-1), S0(c1)) - distance(S0(c2), S0(c2+1));
    % 接收准则
    if delta < 0  || exp(-delta / T) > rand(1)
        S0 = [S0(1:c1-1), S0(c2:-1:c1), S0(c2+1:n+2)];
        sum = sum + delta;
    end

    T = T * alpha;
    if T < e
        break;
    end
end

% 输出巡航路径以及路径长度
S0, sum
data = data * 180 / pi;    % 从弧度制转换回角度制
hold on
for i = 1: n + 1
    scatter(data(S0(i), 1), data(S0(i), 2), 'k');
    plot([data(S0(i), 1), data(S0(i+1), 1)],[data(S0(i), 2), data(S0(i+1), 2)]);
end
plot([data(S0(n+1), 1), data(S0(n+2), 1)],[data(S0(n+1), 2), data(S0(n+2), 2)]);
