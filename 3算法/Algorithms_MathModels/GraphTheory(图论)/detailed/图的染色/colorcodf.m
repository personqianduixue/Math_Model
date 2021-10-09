function [k C] = colorcodf(W)
% 顶点染色算法
% W表示图的邻接矩阵
% k表示算法最终得到的染色数
% C表示顶点染色方案

G = W;
n = size(G,1);
k = 1;C = zeros(1,n);
Z = [1:n];
while sum(find(C==0))
    tcol = find(C == 0);
    m = sum(G(tcol,:),2);
    minm = min(m);
    k1 = find(m==minm, 1 );
    c = G(tcol(k1),:);
    c(1,tcol(k1))=1;
    C(tcol(k1))=k;
    Sn = find(c~=0);
    flag = 1;
    while flag
        tc = setdiff(Z,Sn);
        if isempty(tc)
            flag = 0;
            k = k+1;
        else
            c = G(tc(1),:);
            c(1,tc(1))=1;
            C(tc(1))=k;
            Sn1 = find(c~=0);
            Sn = union(Sn,Sn1);
        end
    end
    trow = (C==k-1);
    G(:,trow)=1;
end
k = k-1;
end

