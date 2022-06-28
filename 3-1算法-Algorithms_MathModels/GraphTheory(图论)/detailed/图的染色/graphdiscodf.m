function [k C W] = graphdiscodf(M)

% 图的邻点可区别染色方案
% M表示任意图的邻接矩阵
% k表示染色数
% C表示顶点染色方案
% W表示边集合的染色方案

[k C W]=graphcodf(M);
n = size(M,1);
C1 = [C' W];
k1 = max(max(C1))+1;
k2 = k1;
for i = 1:n
    for j = (i+1):n
        tms = setdiff(C1(i,:),C1(j,:));
        if isempty(tms)
            C1(j,1)= k1;
            k1 = k1+1;
        end
    end
end
k = k+k1-k2;
C = C1(:,1)';
W = C1(:,2:(n+1));
end

