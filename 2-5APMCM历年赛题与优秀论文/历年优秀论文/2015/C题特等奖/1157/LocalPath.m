
    sim = train*train;    
    % 二阶路径
    sim = sim + lambda * (train*train*train);   
    % 二阶路径 + 参数×三节路径
