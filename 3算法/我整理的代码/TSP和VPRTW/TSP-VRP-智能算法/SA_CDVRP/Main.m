clc %清空命令行窗口
clear %从当前工作区中删除所有变量，并将它们从系统内存中释放
close all %删除其句柄未隐藏的所有图窗
tic % 保存当前时间
%% 模拟退火算法求解CDVRP
%输入：
%City           需求点经纬度
%Distance       距离矩阵
%Demand         各点需求量
%Travelcon      行程约束
%Capacity       车容量约束
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
load('../test_data/Demand.mat')       %需求量
load('../test_data/Travelcon.mat')	  %行程约束
load('../test_data/Capacity.mat')     %车容量约束

%% 初始化问题参数
CityNum=size(City,1)-1;    %需求点个数

%% 初始化算法参数
T0=1000;        %初始温度
Tend=1e-3;      %终止温度
L=200;          %各温度下的迭代次数（链长）
q=0.9;          %降温速率
count=0;        %迭代计数

%% 初始解（必须为满足各约束的可行解）
TSProute=[0,randperm(CityNum)]+1; %随机生成一条不包括尾位的TSP路线
S1=ones(1,CityNum*2+1); %初始化VRP路径S1，为其分配内存
    
DisTraveled=0;  % 汽车已经行驶的距离
delivery=0; % 汽车已经送货量，即已经到达点的需求量之和
k=1;
for j=2:CityNum+1
	k=k+1;   %对VRP路径下一点进行赋值
	if DisTraveled+Distance(S1(k-1),TSProute(j))+Distance(TSProute(j),1) > Travelcon || delivery+Demand(TSProute(j)) > Capacity
        S1(k)=1; %经过配送中心
            
        % 新一辆车再去下一个需求点
        DisTraveled=Distance(1,TSProute(j)); %距离初始化为配送中心到此点距离
        delivery=Demand(TSProute(j)); %新一辆车可配送量初始化
        k=k+1;
        S1(k)=TSProute(j);  %TSP路线中此点添加到VRP路线
	else %
        DisTraveled=DisTraveled+Distance(S1(k-1),TSProute(j));
        delivery=delivery+Demand(TSProute(j)); %累加可配送量
        S1(k)=TSProute(j); %TSP路线中此点添加到VRP路线
	end
end

%% 计算迭代的次数Time，即求解 T0 * q^x = Tend
Time=ceil(double(log(Tend/T0)/log(q)));

bestind=zeros(1,CityNum*2+1);      %每代的最优路线矩阵初始化
BestObjByIter=zeros(Time,1);       %每代目标值矩阵初始化

%% 迭代
while T0 > Tend
    count = count+1;     %更新迭代次数
    Population = zeros(L,CityNum*2+1); %为此温度下迭代个体矩阵分配内存
    ObjByIter = zeros(L,1); %为此温度下迭代个体的目标函数值矩阵分配内存
    for k = 1:L
        %% 产生新解
        S2 = NewSolution(S1);
        %% Metropolis法则判断是否接受新解
        [S1,ttlDis] = Metropolis(S1,S2,Distance,Demand,Travelcon,Capacity,T0);  % Metropolis 抽样算法
        ObjByIter(k) = ttlDis;    %此温度下每迭代一次就存储一次目标函数值
        Population(k,:) = S1;          %此温度下每迭代一次就存储一次此代最优个体
    end
    
    %% 记录每次迭代过程的最优路线
    [d0,index] = min(ObjByIter); %取出此温度下所有迭代中最优的一次
    if count == 1 || d0 < BestObjByIter(count-1) %若为第一次迭代或上次迭代比这次更满意
        BestObjByIter(count) = d0;            %如果当前温度下最优路程小于上一路程则记录当前路程
        bestind = Population(index,:);  %记录当前温度的最优路线
    else
        BestObjByIter(count) = BestObjByIter(count-1);  %如果当前温度下最优路程大于上一路程则记录上一路程的目标函数值
    end
    
    T0 = q * T0; %降温
     %% 显示此代信息
    fprintf('Iteration = %d, Min Distance = %.2f km  \n',count,BestObjByIter(count)) %输出当前迭代信息
end

%% 找出历史最短距离和对应路径
mindisever = BestObjByIter(count); %找出历史最优目标函数值
bestroute=bestind; % 取最优个体

%删去路径中多余1
for i=1:length(bestroute)-1
    if bestroute(i)==bestroute(i+1)
        bestroute(i)=0;  %相邻位都为1时前一个置零
    end
end
bestroute(bestroute==0)=[];  %删去多余零元素

bestroute=bestroute-1;  % 编码各减1，与文中的编码一致

%% 计算结果数据输出到命令行
disp('-------------------------------------------------------------')
toc %显示运行时间
fprintf('Total Distance = %s km \n',num2str(mindisever))
TextOutput(Distance,Demand,bestroute,Capacity)  %显示最优路径
disp('-------------------------------------------------------------')

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
