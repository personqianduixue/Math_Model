function SelCh=Select(Chrom,FitnV,GGAP)
%% 选择操作
%输入
%Chrom 种群
%FitnV 适应度值
%输出
%SelCh  被选择的个体

[NIND,len]=size(Chrom);
SelCh = zeros(NIND*GGAP, len);

%轮盘赌选择法开始
Px=FitnV/sum(FitnV);  %概率归一化为列向量
Px=cumsum(Px);    %轮盘赌概率累加为列向量

for i=1:max(floor(NIND*GGAP+.5),2)   %对于主动选择的每个个体：  % 保证选择超过2条染色体（因为要交叉），且选择的个体数为整数
	theta=rand;  % 不在for里面用rand是因为内部for只用确定的一个随机数rand()
	for j=1:NIND %对于被选择到的，将放到第i个个体位置的个体
		if theta<=Px(j) %若随机数落进这个
			SelCh(i,:)=Chrom(j,:);  %轮盘赌规则确定父亲
			break
		end
	end
end