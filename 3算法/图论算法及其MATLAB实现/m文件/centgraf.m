function [d0 d]=centgraf(W,A)
% 图的中心和加权中心算法
% function [d0 d]=centgraf(W,A)
% W 图的权值矩阵 A 顶点的权值向量
% d0 图的中心 d 图的加权中心
% 两种调用方式
% d0=centgraf(W)
% [d0 d]=centgraf(W,A) % d是加权中心

% 计算最短距离矩阵
n=length(W);  
U=W;
m=1;
while m<=n
for i=1:n
    for j=1:n
        if U(i,j)>U(i,m)+U(m,j)
            U(i,j)=U(i,m)+U(m,j);
        end
    end
end
m=m+1;
end

d1=max(U,[],2); % 计算各行的最大值
d0t=min(d1); % 在最大值中选取最小者
d0=find(d1==min(d1));

dt=zeros(1,n);
for i=1:n
    dt(i)=dot(U(i,:),A); % 计算矩阵di1
end
d=find(dt==min(dt)); % 选取最小者
ddt=min(dt);

% W=[0 1 3 4;1 0 2 90;3 2.2 0 5;4 90 5 0];
% A=[1 2 3 4];