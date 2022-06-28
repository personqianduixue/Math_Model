% 关联度分析
clc,clear
% 一个参考序列，m个比较序列，计算比较系列关于参考序列的关联系数
load example_1.txt
% 标准化数据：注意极性的不同
for i = 1:15
    example_1(i, :) = example_1(i, :) / example_1(i, 1);
end
for i = 16:17
    example_1(i, :) = example_1(i, 1) ./ example_1(i, :);
end

data = example_1
% 1表述维度，行，列，。。。
n = size(data, 1)
% 计算关联系数: ck = 参考， bj = 比较
ck = data(1, :); m1 = size(ck, 1);
bj = data(2:n, :); m2 = size(bj, 1);
for i = 1:m1
    for j = 1:m2
        t(j, :) = bj(j, :) - ck(i, :);
    end
    jc1 = min(min(abs(t'))); jc2 = max(max(abs(t')));
    rho = 0.5;
    ksi = (jc1 + rho*jc2) ./ (abs(t) + rho*jc2);
    rt = sum(ksi') / size(ksi, 2);
    r(i, :) = rt;
end
r % 关联系数向量

% 关联度按照将序排列
[rs, rind] = sort(r, 'descend')