%% 多种群遗传算法
clear;
% clc
% close all
NIND=40;               %个体数目
NVAR=1;                %变量的维数
PRECI=20;              %变量的二进制位数
GGAP=0.9;              %代沟
MP=10;                 %种群数目
FieldD=[PRECI;0;1;1;0;1;1];  %译码矩阵
for i=1:MP
    Chrom{i}=crtbp(NIND, NVAR*PRECI);                       %创建初始种群
end
pc=0.7+(0.9-0.7)*rand(MP,1);    %在【0.7,0.9】范围i内随机产生交叉概率
pm=0.001+(0.05-0.001)*rand(MP,1);  %在【0.001,0.05】范围内随机产生变异概率
gen=0;  %初始遗传代数
gen0=0; %初始保持代数
MAXGEN=10;  %最优个体最少保持代数
maxY=0; %最优值
for i=1:MP
    ObjV{i}=ObjectFunction(bs2rv(Chrom{i}, FieldD));%计算各初始种群个体的目标函数值
end
MaxObjV=zeros(MP,1);           %记录精华种群
MaxChrom=zeros(MP,PRECI*NVAR); %记录精华种群的编码
while gen0<=MAXGEN
    gen=gen+1;       %遗传代数加1
    for i=1:MP
        FitnV{i}=ranking(-ObjV{i});                      % 各种群的适应度
        SelCh{i}=select('sus', Chrom{i}, FitnV{i},GGAP); % 选择操作
        SelCh{i}=recombin('xovsp',SelCh{i}, pc(i));      % 交叉操作
        SelCh{i}=mut(SelCh{i},pm(i));                    % 变异操作
        ObjVSel=ObjectFunction(bs2rv(SelCh{i}, FieldD)); % 计算子代目标函数值
        [Chrom{i},ObjV{i}]=reins(Chrom{i},SelCh{i},1,1,ObjV{i},ObjVSel);    %重插入操作
    end
    [Chrom,ObjV]=immigrant(Chrom,ObjV);     % 移民操作
    [MaxObjV,MaxChrom]=EliteInduvidual(Chrom,ObjV,MaxObjV,MaxChrom);     % 人工选择精华种群
    YY(gen)=max(MaxObjV);    %找出精华种群中最优的个体
    if YY(gen)>maxY   %判断当前优化值是否与前一次优化值相同
        maxY=YY(gen); %更新最优值
        gen0=0;
    else
        gen0=gen0+1; %最优值保持次数加1
    end
end
%% 进化过程图
plot(1:gen,YY)
xlabel('进化代数')
ylabel('最优解变化')
title('进化过程')
xlim([1,gen])
%% 输出最优解
[Y,I]=max(MaxObjV);    %找出精华种群中最优的个体
X=(bs2rv(MaxChrom(I,:), FieldD));   %最优个体的解码解
disp(['最优值为：',num2str(Y)])
disp(['对应的自变量取值：',num2str(X)])
