function W=incandadf(G,f)
% 关联矩阵和邻接矩阵的转化
% G 图的相应矩阵
% f=0, 邻接矩阵转化为关联矩阵
% f=1，关联矩阵转化为邻接矩阵
% W 转化结果

if f==0 % 邻接矩阵转化为关联矩阵
    m=sum(sum(G))/2; % 计算图的边数
    n=size(G,1);
    W=zeros(n,m);
    k=1;
    for i=1:n
        for j=i:n
            if G(i,j)~=0
                W(i,k)=1; % 给边的始点赋值为1
                W(j,k)=1; % 给边的终点赋值为1
                k=k+1;
            end
        end
    end
elseif f==1 % 关联矩阵转化为邻接矩阵
    m=size(G,2);
    n=size(G,1);
    W=zeros(n,n);
    for i=1:m
        a=find(G(:,i)~=0);
        W(a(1),a(2))=1;  %  存在边则邻接矩阵的对应值为1
        W(a(2),a(1))=1;
    end
else
    fprint('please input the right value of f');
end
W;
% G=[0 1 1 1;1 0 1 1;1 1 0 1;1 1 1 0];
% G=[1 1 1 0 0 0;1 0 0 1 1 0;0 1 0 1 0 1;0 0 1 0 1 1];