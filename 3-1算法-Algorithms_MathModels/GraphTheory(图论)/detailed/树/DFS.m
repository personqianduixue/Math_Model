function [ W k f ] = DFS(G)
%深度优先搜索算法
% G是图的邻接矩阵
% W表示图的边的访问顺序
% k表示顶点的标号
% f表示相应顶点的父顶点

% 初始化
n = size(G,1);
W = G;
v=1;
k = zeros(1,n);
f = zeros(1,n);
b = sum(sum((W==1)));
c = sum(k==0);
d = 1;
if b == 0 && c == 0 && v == 1
    d=0;
end
k(1) = 1;
j = 2;
l = 2;

while d
    a = find(W(v,:)==1);
    if isempty(a)
        W(v,f(v))=l;l=l+1;
        v = f(v);
    else
        for i = 1:length(a)
            if k(a(i)) == 0
                k(a(i))=j;
                j=j+1;
                W(v,a(i))=l;
                l=l+1;
                f(a(i))=v;v=a(i);break;
            elseif k(a(i))~=0
                W(v,a(i))=l;l=l+1;
            end
        end
    end
    b = sum(sum(W==1));
    c=sum(k==0);
    if b ==0 && c == 0 && v == 1
        d=0;
    end
end

end

