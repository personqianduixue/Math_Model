%% 主成分分析 (降维)
clc, clear

load example_1.txt  %数据要求：前几列为自变量，最后一列为因变量
data = example_1;

[m, n] = size(data); 
num = 3;   % 选取的主成分的个数

mu = mean(data); 
sigma = std(data);  %标准差
%z-score标准化方法适用于属性A的最大值和最小值未知的情况，或有超出取值范围的离群数据的情况
%标准化的新数据=（原数据-均值）/标准差
std_data = zscore(data);
b = std_data(: , 1:end-1);     % 四个变量x1, x2, x3, x4
r = cov(b);                                % 变量的协方差矩阵

% 运用协方差矩阵进行PCA
[PC, latent, explained] = pcacov(r);  %返回主成分(PC)、协方差矩阵X的特征值 (latent)和每个特征向量表征在观测量总方差中所占的百分数(explained)
% 新的主成分z1 = PC(1,1)*x1 + PC(2,1)*x2 + PC(3,1)*x3 + PC(4,1)*x4  , z2 = ...
f = repmat(sign(sum(PC)), size(PC, 1), 1);            %sum(PC)表示对矩阵PC的列求和
PC = PC .* f;


%1.普通的最小二乘法回归
regress_args_b = [ones(m, 1), b] \ std_data(:, end);   %标准化数据的回归方程系数
bzh = mu ./ sigma;
% 原始数据的常数项
ch10 = mu(end) - bzh(1:end-1) * regress_args_b(2:end) * sigma(end);
fr_1 = regress_args_b(2:end); fr_1 = fr_1';
% 原始数据的自变量的系数
ch1 = fr_1 ./ sigma(1:end-1) * sigma(end);
% 此时模型为 y = ch10 + ch1[1]*x1 + ch1[2] * x2 + ch1[3] * x3 + ch1[4] * x4
% 计算均方误差
check1 = sqrt(sum( (data(:, 1:end-1) * ch1' + ch10 - data(:, end)) .^2 ) / (m - n))


%2.主成分回归模型
pca_val = b * PC(:, 1:num);
%主成分数据的回归方程系数
regress_args_pca = [ones(m, 1), pca_val] \ std_data(:, end);
beta = PC(:, 1:num) * regress_args_pca(2:num+1);   %标准化数据的回归方程系数
% 原始数据的常数项
ch20 = mu(end) - bzh(1:end-1) * beta * sigma(end);
fr_2 = beta';
% 原始数据的自变量的系数
ch2 = fr_2 ./ sigma(1:end-1) * sigma(end);
% 此时模型为 y = ch20 + ch2[1]*x1 + ch2[2] * x2 + ch2[3] * x3 + ch2[4] * x4
% 计算均方误差
check2 = sqrt(sum( (data(:, 1:end-1) * ch2' + ch20 - data(:, end)) .^2 ) / (m - num - 1))
