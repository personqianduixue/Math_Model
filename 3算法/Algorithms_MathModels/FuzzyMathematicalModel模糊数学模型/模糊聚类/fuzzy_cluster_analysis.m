%% 模糊聚类分析的案例
clc, clear

% 建立模糊集合
load data.txt;
A = data;
[m, n] = size(A);

mu = mean(A); sigma = std(A);  % aj与bj
% 求模糊相似矩阵
for i = 1:n
    for j = 1:n
        r(i,j) = exp(-(mu(j)-mu(i))^2 / (sigma(i)+sigma(j))^2);   % r为模糊相似矩阵
    end
end

r1 = fuzzy_matrix_compund(r, r);
r2 = fuzzy_matrix_compund(r1, r1);
r3 = fuzzy_matrix_compund(r2, r2);   % R4的传递闭包，即所求的等价矩阵

b_hat = zeros(n);
lambda = 0.998;
b_hat(find(r2>lambda)) = 1;          % b_hat即反映了分类结果

save data1 r A
