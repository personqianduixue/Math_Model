function [T c]=Krusf(d,flag)
% function [T c]=Krusf(d,flag)
% 求最小生成树的Kruskal算法
%  边权矩阵的产生方法：
%  1)一般的边权矩阵，为nxn维。调用方式[T c]=Krusf(d)
%  2）边权矩阵的前两行分别记录图上所有边的起始顶点和终止顶点，
%     无向边不重复记录。第三行记录对应边的权值。调用方式为[T c]=Krusf(d,1)
%  c:生成树的费用;
%  T:生成树的边集合;

if nargin==1
n=size(d,2);
m=sum(sum(d~=0))/2;
b=zeros(3,m);
k=1;
for i=1:n
    for j=(i+1):n
        if d(i,j)~=0
            b(1,k)=i;b(2,k)=j;
            b(3,k)=d(i,j);k=k+1;
        end
    end
end
else
    b=d;
end

n=max(max(b(1:2,:)));
m=size(b,2);
[B,i]=sortrows(b',3);
B=B';
c=0;T=[];
k=1;t=1:n;
for i=1:m
    if t(B(1,i))~=t(B(2,i))
         T(1:2,k)=B(1:2,i);
         c=c+B(3,i);
         k=k+1;
         tmin=min(t(B(1,i)),t(B(2,i)));
         tmax=max(t(B(1,i)),t(B(2,i)));
         for j=1:n
             if t(j)==tmax
                 t(j)=tmin;
             end
         end
    end
    if k==n
        break;
    end
end
T;
c;