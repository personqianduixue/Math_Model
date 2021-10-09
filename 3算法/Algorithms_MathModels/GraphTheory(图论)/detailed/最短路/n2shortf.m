function [ Path dist] = n2shortf( W,k1,k2)
% W是权值矩阵，k1是起始点，k2是终点
% Path是两点之间的路径
% dist是两点之间最短路径的权值和
% 先利用Floyd算法算出最短距离矩阵
% 然后直接提取所需要的两点之间的路径权值之和
% 最后求出路径

% floyd算法
n = length(W);
U = W;
m = 1;
while m <= n
    for i=1:n
        for j=1:n
            if U(i,j) > U(i,m)+U(m,j)
                U(i,j)=U(i,m)+U(m,j);
            end
        end
    end
    m=m+1;
end
dist = U(k1,k2);

% 求取路径
Path=zeros(1,n);
kk = k1;
Path(1)=k1;
k=1;
while kk~=k2
    for i = 1:n
        T=U(kk,k2) - W(kk,i);
        if T-U(i,k2)<10^(-8) && T-U(i,k2)>=0 && i ~= kk
            Path(k+1)=i;
            kk=i;
            k=k+1;
        end
    end
end
Path=Path(Path~=0);
end

