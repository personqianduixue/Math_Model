
    sim = train * train;               
    % 完成分子的计算，分子同共同邻居算法
    deg_row = repmat(sum(train,1), [size(train,1),1]);
    deg_row = deg_row .* spones(sim);                               
    % 只需保留分子不为0对应的元素
    deg_row = triu(deg_row) + triu(deg_row');                      
    % 计算节点对(x,y)的两节点的度之和
    sim = sim./(deg_row.*spones(sim)-sim); clear deg_row;           
    % 计算相似度矩阵 节点x与y并集的元素数目 = x与y的度之和 - 交集的元素数目
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;