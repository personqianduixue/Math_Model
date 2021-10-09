function [ d0 d ] = centgraf(W,A)
%连通图的中心和加权中心算法
% 若只求图的中心，则调用方式为d0=centgraf(W)
% 若两者均求，则调用方式为[ d0 d ] = centgraf(W,A),其中d0为图的中心
% d是加权中心
% arg：W表示图的权值矩阵,A表示顶点的权重,d0表示图的中心
%      d表示加权中心

% 计算最短距离矩阵
n=length(W);
U = W;
m=1;
while m <= n
    for i = 1:n
        for j = 1:n
            if U(i,j) > U(i,m)+U(m,j)
                U(i,j)= U(i,m)+U(m,j);
            end
        end
    end
    m=m+1;
end

% 计算各行的最大值
d1=max(U,[],2);
% 计算最大值中的最小值
d0t=min(d1);
d0=find(d1==d0t);

% 计算加权中心
dt = zeros(1,n);
for i = 1:n
    dt(i) = dot(U(i,:),A);
end
d = find(dt == min(dt));



end

