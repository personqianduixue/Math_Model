clc %清空命令行窗口
clear %从当前工作区中删除所有变量，并将它们从系统内存中释放
close all %删除其句柄未隐藏的所有图窗
tic % 保存当前时间

%% 蚁群算法求解CVRP
%输入：
%City           需求点经纬度
%Distance       距离矩阵
%Demand         各需求点需求量
%AntNum         种群个数
%Alpha          信息素重要程度因子
%Beta           启发函数重要程度因子
%Rho            信息素挥发因子
%Q              常系数
%Eta            启发函数
%Tau            信息素矩阵
%MaxIter        最大迭代次数

%输出：
%bestroute      最短路径
%mindisever     路径长度

%% 加载数据
load('../test_data/City.mat')	      %需求点经纬度，用于画实际路径的XY坐标
load('../test_data/Distance.mat')	  %距离矩阵
load('../test_data/Demand.mat')       %需求量
load('../test_data/Capacity.mat')     %车容量约束

%% 初始化问题参数
CityNum = size(City,1)-1;    %需求点个数

%% 初始化参数
AntNum = 8;                            % 蚂蚁数量
Alpha = 1;                              % 信息素重要程度因子
Beta = 5;                               % 启发函数重要程度因子
Rho = 0.1;                              % 信息素挥发因子
Q = 1;                                  % 常系数
Eta = 1./Distance;                      % 启发函数
Tau = ones(CityNum+1);                  % (CityNum+1)*(CityNum+1)信息素矩阵  初始化全为1
Population = zeros(AntNum,CityNum*2+1);  % AntNum行,(CityNum*2+1)列 的路径记录表
MaxIter = 100;                           % 最大迭代次数
bestind = ones(1,CityNum*2+1);	% 各代最佳路径
MinDis = zeros(MaxIter,1);              % 各代最佳路径的长度

%% 迭代寻找最佳路径
Iter = 1;                               % 迭代次数初值
while Iter <= MaxIter %当未到达最大迭代次数
	%% 逐个蚂蚁路径选择
    
    maxSubpathLength=zeros(AntNum,1);
	for i = 1:AntNum
        TSProute=2:CityNum+1; %生成一条顺序不包括首尾位的升序TSP路线
        VRProute=[]; %初始化VRP路径
        
        while ~isempty(TSProute)%开辟新的子路径
            subpath=1; %先将配送中心放入子路径起点
            delete=subpath; %delete(end)=1给第一次进入内while的P(k)首项用
            delivery=0; %此子路径的车辆可配送量初始化为零

            while ~isempty(TSProute) %为子路径subpath第二个及以后的位置安排需求点
                %% 计在内while中计算城市间转移概率
                
                P = TSProute; % 为轮盘赌选择建立等于剩余需经过城市数量的长度的向量
                for k = 1:length(TSProute)
                    %delete(end)为刚刚经过的城市，TSProute(k)为剩余可能经过的城市
                    P(k) = Tau(delete(end),TSProute(k))^Alpha * Eta(delete(end),TSProute(k))^Beta; %省略相同分母
                end
                P = P/sum(P);
                % 轮盘赌法选择下一个访问城市
                Pc = cumsum(P); %累加概率
                
                TargetIndex = find(Pc >= rand); %寻找左数第一个大于伪随机数的累加概率的索引
                target = TSProute(TargetIndex(1)); %此索引对应的城市
                %不要强行改变蚂蚁通过轮盘法选到的下一个城市
                %它选到就确定了，然后如果超约束，结束此subpath
                
                %判断容量约束
                if delivery+Demand(target) > Capacity
                    break
                else
                    delivery = delivery+Demand(target); %若符合，则经过的距离累加此距离
                        
                    %此点加入子路径
                    subpath=[subpath,target];
                    %此点加入要删除的点序列
                    delete=[delete,target];
                    
                    %TSP路径中排除已安排的城市
                    TSProute=setdiff(TSProute,delete);
                end
            end %内while结束，此subpath结束
            %直接在VRProute后面填充这条子路径
            maxSubpathLength(i)=max(length(subpath),maxSubpathLength(i));
            VRProute=[VRProute,subpath];
        end %外while结束，此VRProute完整

        %在VRProute后未到CityNum*2+1的空位填入1
        fillwithones = linspace(1,1,CityNum*2+1-length(VRProute));
        VRProute=[VRProute,fillwithones];
        
        %把成型的VRP路径赋给种群矩阵
        Population(i,:)=VRProute;
	end
    
	%% 计算各个蚂蚁的路径距离
	ttlDistance = zeros(AntNum,1); %预分配内存
	for i = 1:AntNum
        DisTraveled=0;  % 蚂蚁子路径已经过的距离
        delivery=0; % 汽车已经送货量，即已经到达点的需求量之和置零
        Dis=0;  %此蚂蚁所有子路径的总距离
        route = Population(i,:); %单独取出一只蚂蚁的路线
        for j=2:length(route)
            DisTraveled = DisTraveled+Distance(route(j-1),route(j)); %每两点间距离累加
            delivery = delivery+Demand(route(j)); %累加可配送量
            if delivery > Capacity
                Dis = Inf;  %对非可行解进行惩罚
                break
            end
            if route(j)==1 %若此位是配送中心
                Dis=Dis+DisTraveled; %累加已行驶距离
                DisTraveled=0; %已行驶距离置零
                delivery=0; %已配送置零
            end
        end
        ttlDistance(i)=Dis; %存储此方案总距离
	end
    
	%% 存储历史最优信息
	if Iter == 1 %若是第一次迭代 不需要与上次迭代结果对比
        [min_Length,min_index] = min(ttlDistance); %取得此次迭代最短距离
        MinDis(Iter) = min_Length; %存储此次迭代最优路线的距离
        bestind = Population(min_index,:); %存储此次迭代最优路径
	else
        [min_Length,min_index] = min(ttlDistance); %取得此次迭代最短距离
        MinDis(Iter) = min(MinDis(Iter-1),min_Length); %与上次迭代结果对比
        if min_Length == MinDis(Iter) %若此代最短距离是在此代中出现
            bestind = Population(min_index,:); %此代最短距离对应的路径赋给此代最优路径
        end
	end
    
	%% 更新信息素
	Delta_Tau = zeros(CityNum+1,CityNum+1); %预分配内存
    
	% 逐个蚂蚁计算
	for i = 1:AntNum
        for j = 1:size(Population,2)-1
            %所有蚂蚁从i到j的信息素累积和：用这一点Delta_Tau之前的值加上新值等于现在的信息素浓度
            Delta_Tau(Population(i,j),Population(i,j+1)) = Delta_Tau(Population(i,j),Population(i,j+1)) + Q/ttlDistance(i);
        end
	end
	Tau = (1-Rho)*Tau+Delta_Tau; %对信息素矩阵进行整体计算，减去挥发，加上新生成的信息素
    
    %% 显示此代信息
    fprintf('Iteration = %d, Min Distance = %.2f km  \n',Iter,MinDis(Iter))
    
    %% 更新迭代次数
	Iter = Iter+1; %迭代次数加1
	%Population = zeros(AntNum,CityNum*2+1); %清空路径记录表
    
end

%% 找出历史最短距离和对应路径
mindisever = MinDis(MaxIter); % 取得历史最优适应值的位置、最优目标函数值
bestroute = bestind; % 取得最优个体

%删去路径中多余1
for i=1:length(bestroute)-1
    if bestroute(i)==bestroute(i+1) %相邻位都为1时
        bestroute(i)=0;  %前一个置零
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

%% 迭代图
figure
plot(MinDis,'LineWidth',2) %展示目标函数值历史变化
xlim([1 Iter-1]) %设置 x 坐标轴范围
set(gca, 'LineWidth',1)
xlabel('Iterations')
ylabel('Min Distance(km)')
title('ACO Process')

%% 绘制实际路线
DrawPath(bestroute,City)
