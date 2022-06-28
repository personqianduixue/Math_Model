clc;
clear all;
close all;
%----------------参数设置-----------------------
MAXGEN=200;                        % 最大遗传代数
sizepop=40;                        % 种群大小
lenchrom=[20 20];          % 每个变量的二进制长度
trace=zeros(1,MAXGEN);
%--------------------------------------------------------------------------      
best=struct('fitness',0,'X',[],'binary',[],'chrom',[]);   % 最佳个体 记录其适应度值、十进制值、二进制编码、量子比特编码
%% 初始化种群
chrom=InitPop(sizepop*2,sum(lenchrom));
%% 对种群实施一次测量 得到二进制编码
binary=collapse(chrom); 
%% 求种群个体的适应度值，和对应的十进制值
[fitness,X]=FitnessFunction(binary,lenchrom);         % 使用目标函数计算适应度
%% 记录最佳个体到best
[best.fitness bestindex]=max(fitness);     % 找出最大值
best.binary=binary(bestindex,:);
best.chrom=chrom([2*bestindex-1:2*bestindex],:);
best.X=X(bestindex,:);
trace(1)=best.fitness;
fprintf('%d\n',1)
%% 进化
for gen=2:MAXGEN
    fprintf('%d\n',gen)  %提示进化代数
    %% 对种群实施一次测量
    binary=collapse(chrom);
    %% 计算适应度
    [fitness,X]=FitnessFunction(binary,lenchrom);
    %% 量子旋转门
    chrom=Qgate(chrom,fitness,best,binary);
    [newbestfitness,newbestindex]=max(fitness);    % 找到最佳值
    % 记录最佳个体到best
    if newbestfitness>best.fitness
        best.fitness=newbestfitness;
        best.binary=binary(newbestindex,:);
        best.chrom=chrom([2*newbestindex-1:2*newbestindex],:);
        best.X=X(newbestindex,:);
    end
    trace(gen)=best.fitness;
end

%% 画进化曲线
plot(1:MAXGEN,trace);
title('进化过程');
xlabel('进化代数');
ylabel('每代的最佳适应度');

%% 显示优化结果
disp(['最优解X：',num2str(best.X)])
disp(['最大值Y:',num2str(best.fitness)]);

