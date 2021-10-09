function len = tsp_len(dis,path)
% dis:N*N邻接矩阵
% 长度为N的向量，包含从1-N的整数

N = length(path);
len = 0;
for i=1:N-1
    len = len + dis(path(i), path(i+1));
    
end

len = len + dis(path(1), path(N));

