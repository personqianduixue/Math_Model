clc %清空命令行窗口
clear %从当前工作区中删除所有变量，并将它们从系统内存中释放
close all %删除其句柄未隐藏的所有图窗
tic % 保存当前时间
%% 遗传算法求解TSP
%输入：
%City           需求点经纬度
%Distance       距离矩阵
%NIND           种群个数
%MAXGEN         遗传到第MAXGEN代时程序停止
%Pc             交叉概率(Probability of Crossover)
%Pm             变异概率(Probability of Mutation)
%GGAP           代沟(probability of Generation GAP)

%输出：
%bestroute      最短路径
%mindisever     路径长度
%% 加载数据
load('../test_data/City.mat')	      %需求点经纬度，用于画实际路径的XY坐标
load('../test_data/Distance.mat')	  %距离矩阵

%% 初始化问题参数
CityNum=size(City,1)-1;    %需求点个数

%% 初始化算法参数
NIND=60;       %种群大小
MAXGEN=100;     %最大遗传代数
GGAP=0.9;       %代沟概率
Pc=0.9;         %交叉概率
Pm=0.05;        %变异概率

%% 为预分配内存而初始化的0矩阵
mindis = zeros(1,MAXGEN);
bestind = zeros(1,CityNum+2);

%% 初始化种群
Chrom=InitPop(NIND,CityNum);

%% 迭代
gen=1;
while gen <= MAXGEN
    %% 计算适应度
    [ttlDistance,FitnV]=Fitness(Distance,Chrom);  %计算路径长度
    [mindisbygen,bestindex] = min(ttlDistance);
    
    mindis(gen) = mindisbygen; % 最小适应值fit的集
	bestind = Chrom(bestindex,:); % 最优个体集
    
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Crossover(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh=Reverse(SelCh,Distance);
    %% 亲代重插入子代
    Chrom=Reins(Chrom,SelCh,FitnV);
    %% 显示此代信息
    fprintf('Num of Iterations = %d,  Min Distance = %.2f km \n',gen,mindisbygen)
    %% 更新迭代次数
    gen=gen+1;
end

%% 找出历史最短距离和对应路径
mindisever = mindis(MAXGEN);  % 取得历史最优适应值的位置、最优目标函数值
bestroute = bestind; % 取得最优个体

%% 计算结果数据输出到命令行
disp('-------------------------------------------------------------')
toc %显示运行时间
TextOutput(bestroute,mindisever)  %显示最优路径

%% 迭代图
figure
plot(mindis,'LineWidth',2) %展示目标函数值历史变化
xlim([1 gen-1]) %设置 x 坐标轴范围
set(gca, 'LineWidth',1)
xlabel('Num of Iterations')
ylabel('Min Distance(km)')
title('GA Optimization Process')

%% 绘制实际路线
DrawPath(bestroute,City)
