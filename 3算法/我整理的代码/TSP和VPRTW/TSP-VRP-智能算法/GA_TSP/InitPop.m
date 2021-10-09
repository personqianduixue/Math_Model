function Chrom=InitPop(NIND,Citynum)
%% 初始化种群
%输入：
% NIND      种群大小
% Citynum   城市的个数
%输出：
%Chrom      初始种群

Chrom=zeros(NIND,Citynum+2); %预分配内存，用于存储种群数据
for i=1:NIND
    Chrom(i,2:end-1)=randperm(Citynum); %随机生成初始种群
end