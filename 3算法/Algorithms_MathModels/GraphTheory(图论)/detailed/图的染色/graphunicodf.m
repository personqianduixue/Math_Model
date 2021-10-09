function [k C W nk] = graphunicodf(M)
% 图的均匀染色方案
% M表示任意图的邻接矩阵
% k表示染色数
% C表示顶点染色方案
% W表示边集合的染色方案
% nk表示统计各种颜色所用的次数

[k C W]=graphcodf(M);
C1 = [C' W];
mk = max(max(C1));
sm = mk;
for i = 1:mk
    a = sum(sum(C1 == i));
    if a > 0
        sm = min([sm a]);
    end
end
G = M;
n = size(G,1);

W = G;
for i = 1:n
    for j = 1:i-1
        W(i,j)=0;
    end
end
C = zeros(1,n);
i = 1;k = 1;
Z = [1:n];
while sum(find(C == 0))
    if C(1,i)==0
        C(1,i)=k;
        num = 1;
        if num-sm > 1
            k = k+1;
        end
        Sn = find(G(i,:)~=0);
        flag = 1;
        while flag
            tc = setdiff(Z,Sn);
            if isempty(tc)
                flag = 0;
            else
                c = G(tc(1),:);
                c(1,tc(1))=1;
                num = num +1;
                if num - sm > 1
                    k = k+1;
                end
                C(tc(1))=k;
                Sn1 = find(c~=0);
                Sn = union(Sn,Sn1);
            end
        end
    end
    for j = i+1:n
        W1 = W;
        if W(i,j) == 1
            k = k + 1;
            W(i,j) = k;
            num = 1;
            if num - sm > 1
                k = k+1;
            end
            W1(:,i) = 0;W1(:,j) = 0;
            W1(i,:) = 0;W1(j,:) = 0;
            m = 0;
            while sum(sum(W1))~=0 && m == 0
                c2 = find(W1~=0);
                c3 = find(W == 1);
                c4 = intersect(c2,c3);
                if ~isempty(c4)
                    k1 = floor(c4(1)/n);
                    k2 = mod(c4(1),n);
                    if k2 == 0
                        k2 = n;
                    end
                    W1(k2,:) = 0;W1(:,k2)=0;
                    W1(k1+1,:)=0;W1(:,k1+1)=0;
                    num = num + 1;
                    if num - sm > 1
                        k = k+1;
                    end
                    if k1 + 1 <k2
                        W(k1+1,k2) = k;
                    else
                        W(k2,k1+1) = k;
                    end
                else
                    m = 1;
                end
            end
        end
    end
    i = 1+1;k = k+1;
end
k = k-1;m = 0;
for i = 1:k
    t1 = find(C == i);
    t2 = find(W == i);
    t3 = sum(t1);
    t4 = sum(sum(t2));
    t5 = t3+t4;
    if t5 ~= 0
        m = m+1;
    end
end
k = m;

C1 = [C' W];
mk = max(max(C1));
nk = zeros(2,k);
l = i;
for i = 1:mk
    a = sum(sum(C1==i));
    if a > 0
        nk(:,l) = [i a];
        l = l+1;
    end
end
end

