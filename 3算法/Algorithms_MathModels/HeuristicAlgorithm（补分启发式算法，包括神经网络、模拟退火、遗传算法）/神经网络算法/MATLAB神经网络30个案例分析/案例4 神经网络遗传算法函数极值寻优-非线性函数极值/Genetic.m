web browser http://www.ilovematlab.cn/thread-61659-1-1.html
%% 清空环境变量
clc
clear

%% 初始化遗传算法参数
%初始化参数
maxgen=100;                         %进化代数，即迭代次数
sizepop=20;                        %种群规模
pcross=[0.4];                       %交叉概率选择，0和1之间
pmutation=[0.2];                    %变异概率选择，0和1之间

lenchrom=[1 1];          %每个变量的字串长度，如果是浮点变量，则长度都为1
bound=[-5 5;-5 5];  %数据范围


individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体
avgfitness=[];                      %每一代种群的平均适应度
bestfitness=[];                     %每一代种群的最佳适应度
bestchrom=[];                       %适应度最好的染色体

%% 初始化种群计算适应度值
% 初始化种群
for i=1:sizepop
    %随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound);   
    x=individuals.chrom(i,:);
    %计算适应度
    individuals.fitness(i)=fun(x);   %染色体的适应度
end
%找最好的染色体
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace=[avgfitness bestfitness]; 

%% 迭代寻优
% 进化开始
for i=1:maxgen
    i
    % 选择
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i maxgen],bound);
    
    % 计算适应度 
    for j=1:sizepop
        x=individuals.chrom(j,:); %解码
        individuals.fitness(j)=fun(x);   
    end
    
  %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度
end
%进化结束

%% 结果分析
[r c]=size(trace);
plot([1:r]',trace(:,2),'r-');
title('适应度曲线','fontsize',12);
xlabel('进化代数','fontsize',12);ylabel('适应度','fontsize',12);
axis([0,100,0,1])
disp('适应度                   变量');
x=bestchrom;
% 窗口显示
disp([bestfitness x]);
web browser http://www.ilovematlab.cn/thread-61659-1-1.html