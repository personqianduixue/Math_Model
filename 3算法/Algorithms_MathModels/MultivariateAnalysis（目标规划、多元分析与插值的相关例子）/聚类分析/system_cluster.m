%% 系统聚类法的一个案例
clc, clear

a = [1 0;
     1 1;
     3 2;
     4 3;
     2 5];
[m, n] = size(a);
y = pdist(a, 'cityblock');  % 将a看成m个大小为n的向量，生成包含距离信息的向量
yc = squareform(y)          % 将距离向量转换为矩阵
z = linkage(y)              % 使用最短距离法生成聚类树
[h, t] = dendrogram(z)