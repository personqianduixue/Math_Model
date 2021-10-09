function [bestCVaccuarcy,bestc,bestg,ga_option] = gaSVMcgForClass(train_label,train,ga_option)
% gaSVMcgForClass
% by faruto
% Email:farutoliyang@gmail.com
% 2009.10.07

%% 参数初始化
if nargin == 2
    ga_option = struct('maxgen',200,'sizepop',20,'pCrossover',0.4,'pMutation',0.01, ...
                'cbound',[0.1,100],'gbound',[0.01,1000],'v',5);
end
% maxgen:最大的进化代数,默认为200,一般取值范围为[100,500]
% sizepop:种群最大数量,默认为20,一般取值范围为[20,100]
% pCrossover:交叉概率,默认为0.4,一般取值范围为[0.4,0.99]
% pMutation:变异概率,默认为0.01,一般取值范围为[0.001,0.1]
% cbound = [cmin,cmax],参数c的变化范围,默认为[0.1,100]
% gbound = [gmin,gmax],参数g的变化范围,默认为[0.01,1000]
% v:SVM Cross Validation参数,默认为3

eps = 10^(-3);

c_len_chromosome = ceil(log2((ga_option.cbound(2)-ga_option.cbound(1))*100));
g_len_chromosome = ceil(log2((ga_option.gbound(2)-ga_option.gbound(1))*100));
len_chromosome = c_len_chromosome+g_len_chromosome;

% 将种群信息定义为一个结构体
individuals=struct('fitness',zeros(1,ga_option.sizepop), ...
                   'chromosome',zeros(ga_option.sizepop,len_chromosome));  
% 每一代种群的平均适应度
avgfitness_gen = zeros(1,ga_option.maxgen);         
% 每一代种群的最佳适应度
bestfitness_gen = zeros(1,ga_option.maxgen);
% 最佳适应度
bestfitness = 0;    
% 适应度最好的染色体
bestchromosome = zeros(1,len_chromosome);                       

%% 初始化种群
for i = 1:ga_option.sizepop
    % 编码
    individuals.chromosome(i,:) = unidrnd(2,1,len_chromosome)-1;
    % 解码
    [c,g] = ga_decode(individuals.chromosome(i,:),ga_option.cbound,ga_option.gbound);
    % 计算初始适应度(CV准确率)
    cmd = ['-v ',num2str(ga_option.v),' -c ',num2str( c ),' -g ',num2str( g )];
    individuals.fitness(i) = svmtrain(train_label, train, cmd);
end

% 找最佳的适应度和最好的染色体的位置
[bestfitness,bestindex]=max(individuals.fitness);
% 最好的染色体
bestchromosome = individuals.chromosome(bestindex,:); 

%% 迭代寻优
for i=1:ga_option.maxgen
    % Selection Operator
    individuals = Selection(individuals,ga_option);
    % Crossover Operator
    individuals = Crossover(individuals,ga_option);
    % Mutation Operator
    individuals = Mutation(individuals,ga_option);
    
    % 计算适应度
    for j = 1:ga_option.sizepop
        % 解码
        [c,g] = ga_decode(individuals.chromosome(j,:),ga_option.cbound,ga_option.gbound);
        % 计算初始适应度(CV准确率)
        cmd = ['-v ',num2str(ga_option.v),' -c ',num2str( c ),' -g ',num2str( g )];
        individuals.fitness(j) = svmtrain(train_label, train, cmd);
    end
    
    if max(individuals.fitness) <= 65
        continue;
    end
    
    % 找最佳的适应度和最好的染色体的位置
    [new_bestfitness,bestindex]=max(individuals.fitness);
    % 最好的染色体
    new_bestchromosome = individuals.chromosome(bestindex,:);
    
    [new_c,g] = ga_decode(new_bestchromosome,ga_option.cbound,ga_option.gbound);
    [c,g] = ga_decode(bestchromosome,ga_option.cbound,ga_option.gbound);

    if new_bestfitness > bestfitness
        bestfitness = new_bestfitness;
        bestchromosome = new_bestchromosome;
    end
    
    if abs( new_bestfitness-bestfitness )<=eps && new_c < c  
        bestfitness = new_bestfitness;
        bestchromosome = new_bestchromosome;
    end
    
    % 这一代染色体的最佳适应度
    bestfitness_gen(i) = bestfitness;
    % 这一代染色体的平均适应度
    avgfitness_gen(i) = sum(individuals.fitness)/ga_option.sizepop;
    
end

%% 结果分析
figure;
hold on;
plot(bestfitness_gen,'r*-','LineWidth',1.5);
plot(avgfitness_gen,'o-','LineWidth',1.5);
legend('最佳适应度','平均适应度',3);
% title(['适应度曲线Accuracy[GAmethod]','(终止代数=', ...
%        num2str(ga_option.maxgen), ...
%        ',种群数量pop=', ...
%        num2str(ga_option.sizepop),')'],'FontSize',12);
xlabel('进化代数','FontSize',12);
ylabel('适应度','FontSize',12);
axis([0 ga_option.maxgen 0 100]);
grid on;

% print -dtiff -r600 ga;

[bestc,bestg] = ga_decode(bestchromosome,ga_option.cbound,ga_option.gbound);
bestCVaccuarcy = bestfitness_gen(ga_option.maxgen);

line1 = '适应度曲线Accuracy[GAmethod]';
line2 = ['终止代数=', ...
    num2str(ga_option.maxgen),',种群数量pop=', ...
    num2str(ga_option.sizepop),')'];
line3 = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
    ' CVAccuracy=',num2str(bestCVaccuarcy),'%'];
title({line1;line2;line3},'FontSize',12);

%% sub function ga_decode
function [c,g] = ga_decode(chromosome,cbound,gbound)
% ga_decode by faruto 
% Email:farutoliyang@gmail.com
% 2009.10.08
c_len_chromosome = ceil(log2((cbound(2)-cbound(1))*100));
g_len_chromosome = ceil(log2((gbound(2)-gbound(1))*100));
len_chromosome = c_len_chromosome+g_len_chromosome;

cdec = bin2dec( num2str(chromosome(1:c_len_chromosome)) );
gdec = bin2dec( num2str(chromosome(c_len_chromosome+1:len_chromosome)) );

c = cbound(1) + cdec*(cbound(2)-cbound(1))/(2^(c_len_chromosome)-1);
g = gbound(1) + gdec*(gbound(2)-gbound(1))/(2^(g_len_chromosome)-1);

%% sub function Selection
function individuals_afterSelect = Selection(individuals,ga_option)
% Selection by faruto 
% Email:farutoliyang@gmail.com
% 2009.10.08
individuals_afterSelect = individuals;
sum_fitness = sum(individuals.fitness);
P = individuals.fitness / sum_fitness;
Q = zeros(1,ga_option.sizepop);
for k = 1:ga_option.sizepop
    Q(k) = sum(P(1:k));
end

for i = 1:ga_option.sizepop
    r = rand;
    while r == 0
        r = rand;
    end
    k = 1;
    while k <= ga_option.sizepop-1 && r > Q(k) 
        k = k+1; 
    end
%     individuals_afterSelect.fitness(i) = individuals.fitness(k);
    individuals_afterSelect.chromosome(i,:) = individuals.chromosome(k,:);
end

%% sub function Crossover
function individuals_afterCross = Crossover(individuals,ga_option)
% Crossover by faruto 
% Email:farutoliyang@gmail.com
% 2009.10.08
individuals_afterCross = individuals;
c_len_chromosome = ceil(log2((ga_option.cbound(2)-ga_option.cbound(1))*100));
g_len_chromosome = ceil(log2((ga_option.gbound(2)-ga_option.gbound(1))*100));
len_chromosome = c_len_chromosome+g_len_chromosome;

for i = 1:ga_option.sizepop
    % 交叉概率决定是否进行交叉
    r = rand;
    if r > ga_option.pCrossover
        continue;
    end
    % 随机选择两个染色体进行交叉
    pick=rand(1,2);
    while prod(pick)==0
        pick=rand(1,2);
    end
    index=ceil(pick.*ga_option.sizepop);
    
    % 随机选择交叉位置
    pos_cross = unidrnd(len_chromosome-1);
    % 进行交叉
    individuals_afterCross.chromosome(index(1),pos_cross+1:len_chromosome) ...
        = individuals.chromosome(index(2),pos_cross+1:len_chromosome);
    individuals_afterCross.chromosome(index(2),pos_cross+1:len_chromosome) ...
        = individuals.chromosome(index(1),pos_cross+1:len_chromosome);
end

%% sub function Mutation
function individuals_afterMutate = Mutation(individuals,ga_option)
% Mutation by faruto 
% Email:farutoliyang@gmail.com
% 2009.10.08
individuals_afterMutate = individuals;
c_len_chromosome = ceil(log2((ga_option.cbound(2)-ga_option.cbound(1))*100));
g_len_chromosome = ceil(log2((ga_option.gbound(2)-ga_option.gbound(1))*100));
len_chromosome = c_len_chromosome+g_len_chromosome;

for i = 1:ga_option.sizepop
    % 变异概率决定是否进行交叉
    r = rand;
    if r > ga_option.pMutation
        continue;
    end
    % 随机选择一个染色体进行变异
    pick = unidrnd(ga_option.sizepop);
    % 随机选择变异位置
    pos_mutate = unidrnd(len_chromosome);
    % 进行变异
    if individuals_afterMutate.chromosome(pick,pos_mutate) == 0
       individuals_afterMutate.chromosome(pick,pos_mutate) = 1;
    else
       individuals_afterMutate.chromosome(pick,pos_mutate) = 0;
    end
end