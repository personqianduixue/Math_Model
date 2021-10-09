%% 变量聚类法
clc, clear

a = textread('data.txt');
for i = 1:14
    a(i,i) = 0;
end

b = a(:); b = nonzeros(b);
b = b'; b = 1 - b;
z = linkage(b, 'complete');
y = cluster(z, 2);
dendrogram(z);
ind1 = find(y==2); ind1 = ind1'
ind2 = find(y==1); ind2 = ind2'