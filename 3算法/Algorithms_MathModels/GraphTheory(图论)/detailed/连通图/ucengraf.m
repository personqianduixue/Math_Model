function [ d ] = ucengraf(W)
%求连通无向图的一般中心


% 计算最短距离矩阵
n=length(W);
U = W;
m=1;
while m <= n
    for i = 1:n
        for j = 1:n
            if U(i,j) > U(i,m)+U(m,j)
                U(i,j) = U(i,m)+U(m,j);
            end
        end
    end
    m=m+1;
end

for m=1:n
    k=1;
    for i = 1:n
        for j = 1:n
            if W(i,j) ~= 0 && W(i,j) ~= inf
                D(m,k)=0.5*(U(m,i)+W(i,j)+U(m,j));
                k=k+1;
            end
        end
    end
end
d1 = max(D,[],2);
d = find(d1==min(d1));
end

