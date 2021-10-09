function Chrom=Reins(Chrom,SelCh,FitnV)
%% 重插入子代的新种群
%输入：
%Chrom      亲代的种群
%SelCh      子代种群
%ObjV       亲代适应度
%输出
%Chrom      组合亲代与子代后得到的新种群
 
NIND=size(Chrom,1); %亲代种群个体数
NSel=size(SelCh,1); %参与此代进化的个体数
[~,index] = sort(FitnV,'descend'); %亲代个体的适应度降序排列
Chrom=[Chrom(index(1:NIND-NSel),:);SelCh]; %先把参与此代进化的个体全部放入下代亲代，再把亲代个体适应度高的放入剩下的位置