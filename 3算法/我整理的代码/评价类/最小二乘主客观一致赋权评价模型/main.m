%来源：2019第9届mathorcup B题优秀论文
clear
close all
clc
charct_vector = 6; %评价对象个数
charct_totalnum = 4; %评价指标个数
x = [1874.2, 0.0401, 132, 0.3728; ...
    4959.0, 0.0627, 109, 0.2806; ...
    8273.0, 0.0764, 95, 0.2389; ...
    1874.2, 0.0401, 132, 0.3728; ...
    4959.0, 0.0627, 109, 0.2806; ...
    8273.0, 0.0764, 95, 0.2389];
u = zeros(charct_totalnum, 1);
v = zeros(charct_totalnum, 1);
for i = 1:6
    for j = 2:4
        r1(i, j) = (max(x(i, :)) - x(i, j)) / (max(x(i, :)) - min(x(i, :))); %%%越小越优的归一化处理
    end
end
for i = 1:6
    for j = 1:1
        r1(i, j) = (x(i, j) - min(x(i, :))) / (max(x(i, :)) - min(x(i, :))); %%%越大越优的归一化处理
    end
end
%%层次分析法%构建新特征参数
A = [1, 2, 3, 3; 1 / 2, 1, 2, 2; 1 / 3, 1 / 2, 1, 2; 1 / 3, 1 / 2, 1 / 2, 1]; %判断矩阵
[V, DD] = eig(A); %求A的特征值构成对角阵D，特征向量构成V的列向量
q = V(:, 1); %q向量即为权重向量
for i = 1:charct_totalnum
    u(i) = q(i, 1); %q 4x1
end %计算新定义特征参数
%%熵值法
entropy_sum = zeros(charct_totalnum, 1);
for i = 1:charct_totalnum
    for j = 1:charct_vector
        entropy_sum(i, 1) = entropy_sum(i, 1) + r1(j, i);
    end
end
f = zeros(charct_totalnum, charct_vector);
for i = 1:charct_totalnum %计算f
    for j = 1:charct_vector
        f(i, j) = r1(j, i) / entropy_sum(i, 1);
        if f(i, j) == 0
            f(i, j) = 1;
        end
    end
end
k = -1 / (log(charct_vector));
h = zeros(charct_totalnum, 1);
sum_f = zeros(charct_totalnum, 1);
for i = 1:charct_totalnum
    for j = 1:charct_vector
        sum_f(i, 1) = sum_f(i, 1) + f(i, j) * log(f(i, j));
    end
    h(i, 1) = k * sum_f(i, 1); %熵值
end
w2 = zeros(charct_totalnum, 1);
sum_h = 0;
for i = 1:charct_totalnum
    sum_h = sum_h + h(i, 1);
end
for i = 1:charct_totalnum
    w2(i, 1) = (1 - h(i, 1)) / (charct_totalnum - sum_h);
    v(i) = w2(i, 1);
end %熵权
%%综合优化评价
A1 = diag([sum(r1(:, 1).^2), sum(r1(:, 2).^2), sum(r1(:, 3).^2), sum(r1(:, 4).^2)], 0);
E1 = [1, 1, 1, 1]';
B1 = [(u(1) + v(1)) * sum(r1(:, 1).^2) / 2, (u(2) + v(2)) * sum(r1(:, 2).^2) / 2, (u(3) + v(3)) * sum(r1(:, 3).^2) / 2, (u(4) + v(4)) * sum(r1(:, 4).^2) / 2]';
W1 = inv(A1) * (B1 + (1 - E1' * inv(A1) * B1) / (E1' * inv(A1) * E1) * E1);
[m1, n1] = size(r1); %%%矩阵单位化
for i = 1:n1
    R1(1, i) = norm(r1(:, i));
end
R1 = repmat(R1, m1, 1);
z1 = r1 ./ R1;
for j = 1:4
    ye_z(j) = max(z1(:, j).*W1(j)); %%正理想方案
    ye_f(j) = min(z1(:, j).*W1(j)); %%负理想方案
    for i = 1:6
        L(i) = sqrt(sum((z1(i, :) .* W1(j) - ye_z(j)).^2));
        D(i) = sqrt(sum((z1(i, :) .* W1(j) - ye_f(j)).^2));
        F(i) = D(i) / (L(i) + D(i));
    end
end
L,D,F