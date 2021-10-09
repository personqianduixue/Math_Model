clc %清空命令行窗口
clear %从当前工作区中删除所有变量，并将它们从系统内存中释放
close all %删除其句柄未隐藏的所有图窗
tic % 保存当前时间
%% 模拟退火算法求解TSP
%输入：
%City           需求点经纬度
%Distance       距离矩阵
%T0             初始温度
%Tend           终止温度
%L              各温度下的迭代次数（链长）
%q              降温速率

%输出：
%bestroute      最短路径
%mindisever     路径长度
%% 加载数据
load('../test_data/City.mat')	      %需求点经纬度，用于画实际路径的XY坐标
load('../test_data/Distance.mat')	  %距离矩阵

%% 初始化问题参数
CityNum=size(City,1)-1;    %需求点个数

%% 初始化算法参数
T0=1000;        %初始温度
Tend=1e-3;      %终止温度
L=200;          %各温度下的迭代次数（链长）
q=0.9;          %降温速率
count=0;        %迭代计数

%% 初始解
S1=[0,randperm(CityNum),0];  %随机产生一个初始路线

%% 计算迭代的次数Time，即求解 T0 * q^x = Tend
Time=ceil(double(log(Tend/T0)/log(q)));

bestind=zeros(1,CityNum+2);      %历史最优个体
BestObjByIter=zeros(Time,1);       %每代目标值矩阵初始化

%% 迭代
while T0 > Tend
    count = count+1;     %更新迭代次数
    Population = zeros(L,CityNum+2); %为此温度下迭代个体矩阵分配内存
    ObjByIter = zeros(L,1); %为此温度下迭代个体的目标函数值矩阵分配内存
    for k = 1:L
        %% 产生新解
        S2 = NewSolution(S1);
        %% Metropolis法则判断是否接受新解
        [S1,ttlDis] = Metropolis(S1,S2,Distance,T0);  % Metropolis 抽样算法
        ObjByIter(k) = ttlDis;    %此温度下每迭代一次就存储一次目标函数值
        Population(k,:) = S1;          %此温度下每迭代一次就存储一次此代最优个体
    end
    
    %% 记录每次迭代过程的最优路线
    [d0,index] = min(ObjByIter); %取出此温度下所有迭代中最优的一次
    if count == 1 || d0 < BestObjByIter(count-1) %若为第一次迭代或上次迭代比这次更满意
        BestObjByIter(count) = d0;            %如果当前温度下最优路程小于上一路程则记录当前路程
        bestind = Population(index,:);  %记录当前温度的最优路线
    else
        BestObjByIter(count) = BestObjByIter(count-1);    %如果当前温度下最优路程大于上一路程则记录上一路程的目标函数值
    end
    
    T0 = q * T0; %降温
     %% 显示此代信息
    fprintf('Iteration = %d, Min Distance = %.2f km  \n',count,BestObjByIter(count)) %输出当前迭代信息
end

%% 找出历史最短距离和对应路径
mindisever = BestObjByIter(count); %找出历史最优目标函数值
bestroute = bestind; % 取得最优个体

%% 输出最优解的路线和总距离
disp('-------------------------------------------------------------')
toc %显示运行时间
TextOutput(bestroute,mindisever)  %显示最优路径

%% 优化过程迭代图
figure
plot(BestObjByIter,'LineWidth',2)
xlim([1 count]) %设置 x 坐标轴范围
set(gca, 'LineWidth',1)
xlabel('Iterations')
ylabel('Min Distance(km)')
title('SA Optimization Process')

%% 绘制最优解的实际路线
DrawPath(bestroute,City)
