%% 初始化种群
%输入：
% NIND：种群大小
% N：   个体染色体长度（这里为城市的个数）  
%输出：
%初始种群
function Chrom=InitPop(NIND,N)
Chrom=zeros(NIND,N);%用于存储种群
for i=1:NIND
    Chrom(i,:)=randperm(N);%随机生成初始种群
end