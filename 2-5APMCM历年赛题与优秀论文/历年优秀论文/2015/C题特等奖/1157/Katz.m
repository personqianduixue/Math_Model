    sim = inv( sparse(eye(size(train,1))) - lambda * train);   
    % 相似性矩阵的计算
    sim = sim - sparse(eye(size(train,1)));