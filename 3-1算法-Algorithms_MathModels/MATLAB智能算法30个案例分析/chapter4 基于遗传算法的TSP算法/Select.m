%% 选择操作
%输入
%Chrom 种群
%FitnV 适应度值
%GGAP：代沟
%输出
%SelCh  被选择的个体
function SelCh=Select(Chrom,FitnV,GGAP)
NIND=size(Chrom,1);
NSel=max(floor(NIND*GGAP+.5),2);
ChrIx=Sus(FitnV,NSel);
SelCh=Chrom(ChrIx,:);