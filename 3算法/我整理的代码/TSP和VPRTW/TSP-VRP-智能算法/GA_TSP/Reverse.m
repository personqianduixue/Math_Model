function SelCh=Reverse(SelCh,Distance)
%% 进化逆转函数
%输入：
%SelCh          被选择的个体
%Distance       个城市的距离矩阵
%输出：
%SelCh          进化逆转后的个体

[ttlDistance,~]=Fitness(Distance,SelCh);  %计算路径长度
SelCh1=SelCh; %临时存储

SelCh1=Mutate(SelCh1,1); %一定变异

[ttlDistance1,~]=Fitness(Distance,SelCh1); %计算变异后的个体路径长度
index=ttlDistance1<ttlDistance; %若变异后的个体路径长度更短，将这些个体在种群中的索引提取出来
SelCh(index,:)=SelCh1(index,:); %则替换原染色体
