% 有向图的关联矩阵和邻接矩阵转化
function W=mattransf(G,f)
% f=0, 邻接矩阵转化为关联矩阵
% f=1，关联矩阵转化为邻接矩阵

if f==0 % 邻接矩阵转化为关联矩阵
    m=sum(sum(G));
    n=size(G,1);
    W=zeros(n,m);
    k=1;
    for i=1:n
        for j=1:n
            if G(i,j)~=0 % 由i发出的边，有向边的始点
                W(i,k)=1; % 关联矩阵始点值为1
                W(j,k)=-1; % 关联矩阵终点值为-1
                k=k+1;
            end
        end
    end
elseif f==1 % 关联矩阵转化为邻接矩阵
    m=size(G,2);
    n=size(G,1);
    W=zeros(n,n);
    for i=1:m
        a=find(G(:,i)~=0); % 有向边的两个顶点
        if G(a(1),i)==1
            W(a(1),a(2))=1; % 有向边由a(1)指向a(2)
        else
            W(a(2),a(1))=1; % 有向边由a(2)指向a(1)
        end
    end
else
    fprint('please input the right value of f');
end
W;
