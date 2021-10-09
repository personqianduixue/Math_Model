clc, clear
a=[1 1 1 1;1 1 1 0;1 1 0 1;1 0 1 1;1 0 1 0
   0 1 0 1;0 1 0 0;0 0 1 0;0 0 0 1; 0 0 0 0]; %每一行是一个可行状态
b=[1 0 0 0;1 1 0 0;1 0 1 0;1 0 0 1]; %每一行是一个转移状态
w=zeros(10); %邻接矩阵初始化
for i=1:9
    for j=i+1:10
        for k=1:4
            if findstr(mod(a(i,:)+b(k,:),2),a(j,:))
                w(i,j)=1;
            end
        end
    end
end
w=w'; %变成下三角矩阵
[i,j,v]=find(w);  %找非零元素
c=sparse(i,j,v,10,10) %构造稀疏矩阵
[x,y,z]=graphshortestpath(c,1,10,'Directed',false)  % 该图是无向图
h = view(biograph(c,[],'ShowArrows','off','ShowWeights','off'));
Edges = getedgesbynodeid(h); %提取句柄h中的边集
set(Edges,'LineColor',[0 0 0]); %为了将来打印清楚，边画成黑色
set(Edges,'LineWidth',1.5);  %线型宽度设置为1.5