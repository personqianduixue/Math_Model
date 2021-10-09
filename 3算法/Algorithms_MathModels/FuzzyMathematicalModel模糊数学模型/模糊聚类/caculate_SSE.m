function err = caculate_SSE(a, t)
    % 计算误差平方和
    b = a;
    b(:,t) = [];
    mu1 = mean(a, 2);
    mu2 = mean(b, 2);
    err = sum((mu1-mu2).^2);
end