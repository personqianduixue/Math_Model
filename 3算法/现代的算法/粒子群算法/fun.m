%下面是一个最基本的pso算法解决函数极值问题，如果是一些大型的问题，需要对速度、惯性常数、和自适应变异做进一步优化，希望对你有帮助

function y = fun(x)%--------X是不是粒子群的粒子最开始位置，请验证------------
y=-20*exp(-0.2*sqrt((x(1)^2+x(2)^2)/2))-exp((cos(2*pi*x(1))+cos(2*pi*x(2)))/2)+20+2.71289;
%下面是主程序
%% 清空环境
clc
clear

%% 参数初始化
%粒子群算法中的两个参数
c1 = 1.49445;
c2 = 1.49445;

maxgen=200;   % 进化次数  
sizepop=20;   %种群规模

Vmax=1;%速度限制
Vmin=-1;
popmax=5;%种群限制
popmin=-5;

%% 产生初始粒子和速度
for i=1:sizepop
    %随机产生一个种群
    pop(i,:)=5*rands(1,2);    %初始种群
    V(i,:)=rands(1,2);  %初始化速度
    %计算适应度
    fitness(i)=fun(pop(i,:));   %染色体的适应度
end

%找最好的染色体
[bestfitness bestindex]=min(fitness);
zbest=pop(bestindex,:);   %全局最佳
gbest=pop;    %个体最佳
fitnessgbest=fitness;   %个体最佳适应度值
fitnesszbest=bestfitness;   %全局最佳适应度值

%% 迭代寻优
for i=1:maxgen
    
    for j=1:sizepop
        
        %速度更新
        V(j,:) = V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));
        V(j,find(V(j,:)>Vmax))=Vmax;
        V(j,find(V(j,:)<Vmin))=Vmin;
        
        %种群更新
        pop(j,:)=pop(j,:)+0.5*V(j,:);
        pop(j,find(pop(j,:)>popmax))=popmax;
        pop(j,find(pop(j,:)<popmin))=popmin;
        
        %自适应变异（避免粒子群算法陷入局部最优）
        if rand>0.8
            k=ceil(2*rand);%ceil朝正无穷大方向取整
            pop(j,k)=rand;
        end
      
        %适应度值
        fitness(j)=fun(pop(j,:));
        
        
        %个体最优更新
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %群体最优更新
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
        
    end
    yy(i)=fitnesszbest;    
        
end

%% 结果分析， 并且实现了绘图的功能
plot(yy)
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');