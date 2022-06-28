function binary=collapse(chrom)
%% 对种群实施一次测量 得到二进制编码
% 输入chrom ：为量子比特编码
% 输出binary：二进制编码
[M,N]=size(chrom);  %得到种群大小 和编码长度
M=M/2;  % 种群大小
binary=zeros(M,N);  %二进制编码大小初始化
for i=1:M
    for j=1:N
        pick=rand;  %产生【0,1】随机数
        if pick>(chrom(2.*i-1,j)^2)    % 随机数大于α的平方
            binary(i,j)=1;
        else
            binary(i,j)=0;
        end
    end
end