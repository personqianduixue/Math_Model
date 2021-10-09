function ab = fuzzy_matrix_compund(a, b)
% 将模糊矩阵a和b合成，赋值给ab
% 模糊矩阵的一列代表一个等级的各个指标的值，行数代表了指标的个数
% 列数代表了等级的个数
    m = size(a, 1);
    n = size(b, 2);
    for i = 1:m
        for j = 1:n
            ab(i,j) = max(min([a(i,:); b(:,j)']));
        end
    end
end