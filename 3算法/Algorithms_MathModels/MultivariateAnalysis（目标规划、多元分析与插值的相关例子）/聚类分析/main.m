%% 聚类分析的一个典型案例
% 对变量进行R型聚类，对样本进行Q型聚类

% 将指标看成变量，进行R型聚类
load edu.txt
data = edu;
r = corrcoef(data);   % 计算相关系数矩阵
[m, n] = size(data);  % m为样本个数，n为指标个数
d = tril(r);         % 取出下三角元素
for i = 1:n
    d(i,i) = 0;
end

d = d(:);
d = nonzeros(d);     % 取出非零元素
d = d';
d = 1 -d;
z = linkage(d)
dendrogram(z)
% 根据需要，从n项指标中挑选几个进行下一轮的分析

% 假设选取6项指标，接下来对m个样本进行Q型聚类
data(:,3:6) = [];    % 由于选取的指标是第1,2,7,8,9,10项，故删除中间无用信息
data = zscore(data);
y = pdist(data);
z = linkage(y)
dendrogram(z, 'average')