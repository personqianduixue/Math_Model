function D = shortdf(W)
%连通图中各顶点间最短距离的计算
% Floyd算法
%arg:邻接矩阵，对于W(i,j)，若两点间存在弧，则为弧的权值
%否则为inf；当i=j时，W(i,j)=0
n = length(W);
D=W;
m=1;
while m<= n
    for i = 1:n
        for j = 1:n
            if D(i,j) > D(i,m)+D(m,j)
                D(i,j)=D(i,m)+D(m,j);
            end
        end
    end
    m=m+1;
end
D;

end

