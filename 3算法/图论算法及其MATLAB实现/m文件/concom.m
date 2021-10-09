function [S,Q]=concom(G)
% 图的连通性计算
% function [S,Q]=concom(G)
% G 图的邻接矩阵
% S 图的连通块数 Q 图的顶点所在的块号

n=size(G,1);
m=sum(sum(G))/2;
S=0;j=1;C=1;
Q=zeros(n,1);
for i=1:n
    for j=(i+1):n
        if G(i,j)==1  % 两者之间有边
        if Q(i)==Q(j) % 两者之间有边则属于同一块
            if Q(i)==0
                Q(i)=C;Q(j)=C; 
                C=C+1;
                S=S+1;
            end
        else
            if Q(i)==0 % 若为标记i则与j在同一块
                Q(i)=Q(j);
            elseif Q(j)==0 % 若为标记j则与i在同一块
                Q(j)=Q(i);
            else   % 若两者相连，但标记为不同的块，则进行块合并
                for k=1:n
                    if Q(k)==Q(i)
                        Q(k)=Q(j); % 将两块合并
                    end
                end
                S=S-1;
            end
        end
        end
    end
end
S;
Q;
% G=[1 0 1 1;1 1 0 1;1 1 1 1;1 0 1 1]   
% G=[0 1 0 0;1 0 0 0;0 0 0 1;0 0 1 0] 