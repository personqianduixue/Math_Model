function chrom=InitPop(M,N)
%% 初始化种群-量子比特编码
% M:为种群大小×2，(α和β)
% N:为量子比特编码长度
for i=1:M
    for j=1:N
        chrom(i,j)=1/sqrt(2);
    end
end