%% 模糊聚类完毕之后，给出解决方案
load data1

% 调用fuzzy_cluster_analysis.m之后的分类结果
ind1 = [1,5];
ind2 = [2:3,6,8:11];
ind3 = [4,7];

so = [];
% 即从三类中各选出一个去掉，循环计算每一种去掉的方案带来的误差平方和，找到最小的那个即可
for i = 1:length(ind1)
    for j = 1:length(ind3)
        for k = 1:length(ind2)
            t = [ind1(i), ind3(j), ind2(k)];
            err = caculate_SSE(A, t);
            so = [so;[t,err]];
        end
    end
end

so
tm = find(so(:,4) == min(so(:,4)));

result = so(tm,1:3)
