function [MaxObjV,MaxChrom]=EliteInduvidual(Chrom,ObjV,MaxObjV,MaxChrom)
%% 人工选择算子
MP=length(Chrom);  %种群数
for i=1:MP
    [MaxO,maxI]=max(ObjV{i});   %找出第i种群中最优个体
    if MaxO>MaxObjV(i)
        MaxObjV(i)=MaxO;         %记录各种群的精华个体
        MaxChrom(i,:)=Chrom{i}(maxI,:);  %记录各种群精华个体的编码
    end
end
