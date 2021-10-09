function N1 = Riemann_closeness(x)
    % 求解黎曼贴近度
    N1 = quadl(@minimun, 0, 100) / quadl(@maximun, 0, 100);
    
end