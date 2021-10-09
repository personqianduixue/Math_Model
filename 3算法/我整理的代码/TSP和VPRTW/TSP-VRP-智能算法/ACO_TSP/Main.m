clc %清空命令行窗口
clear %从当前工作区中删除所有变量，并将它们从系统内存中释放
close all %删除其句柄未隐藏的所有图窗
tic % 保存当前时间
%% 蚁群算法求解TSP
%输入：
%City           需求点经纬度
%Distance       距离矩阵
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
Population = ones(AntNum,CityNum+2);           % 路径记录表
MaxIter = 100;                           % 最大迭代次数
bestind = ones(1,CityNum+2);      % 各代最佳路径
MinDis = zeros(MaxIter,1);              % 各代最佳路径的长度

%% 迭代寻找最佳路径
Iter = 1;                               % 迭代次数初值
while Iter <= MaxIter %当未到达最大迭代次数
	%% 随机产生各个蚂蚁的起点城市
	start = ones(AntNum,1);  %预分配内存
	for i = 1:AntNum
        temp = randperm(CityNum)+1; %TSP路径索引乱序排列
        start(i,1) = temp(1);%TSP起点随机在任一需求点
	end
	Population(:,2) = start;  %第一列1表示配送中心
	% 构建解空间
	CityIndex = 2:CityNum+1; %可选城市索引从第一个城市代表的2到最后一个城市
    
	%% 逐个蚂蚁路径选择
	for i = 1:AntNum
        % 第二个到最后一个不包括配送中心的要经过的城市路径选择
        for j = 3:CityNum+1
            tabu = Population(i,2:(j - 1));  % 已访问的城市集合(禁忌表)  Pop为向量
            AllowIndex = ~ismember(CityIndex,tabu); %CityIndex在tabu中不存在的元素在CityIndex的索引
            allow = CityIndex(AllowIndex); % 待访问的城市集合
            P = allow; %为轮盘赌选择建立等于剩余需经过城市数量的长度的向量
            
           %% 计算城市间转移概率
            for k = 1:length(allow)
                P(k) = Tau(tabu(end),allow(k))^Alpha * Eta(tabu(end),allow(k))^Beta; %省略相同分母
            end
            P = P/sum(P);
            % 轮盘赌法选择下一个访问城市
            Pc = cumsum(P); %累加概率
            TargetIndex = find(Pc >= rand); %寻找左数第一个大于伪随机数的累加概率的索引
            target = allow(TargetIndex(1)); %此索引对应的城市
            Population(i,j) = target; %此城市为此蚂蚁下一个将要移动到的城市
        end
	end
    
	%% 计算各个蚂蚁的路径距离
	Length = zeros(AntNum,1); %预分配内存
	for i = 1:AntNum
        Route = Population(i,:); %单独取出一只蚂蚁的路线
        for j = 1:CityNum+1
            Length(i) = Length(i) + Distance(Route(j),Route(j + 1)); %计算此路线总距离
        end
	end
    
	%% 存储历史最优信息
	if Iter == 1 %若是第一次迭代 不需要与上次迭代结果对比
        [min_Length,min_index] = min(Length); %取得此次迭代最短距离
        MinDis(Iter) = min_Length; %存储此次迭代最优路线的距离
        bestind = Population(min_index,:); %存储此次迭代最优路径
	else
        [min_Length,min_index] = min(Length); %取得此次迭代最短距离
        MinDis(Iter) = min(MinDis(Iter-1),min_Length); %与上次迭代结果对比
        if min_Length == MinDis(Iter) %若此代最短距离是在此代中出现
            bestind = Population(min_index,:); %此代最短距离对应的路径赋给此代最优路径
        end
	end
    
	%% 更新信息素
	Delta_Tau = zeros(CityNum+1,CityNum+1); %预分配内存
    
	%% 逐个蚂蚁计算
	for i = 1:AntNum
        % 逐个城市计算
        for j = 1:CityNum+1
            Delta_Tau(Population(i,j),Population(i,j+1)) = Delta_Tau(Population(i,j),Population(i,j+1)) + Q/Length(i); %所有蚂蚁从i到j的信息素累积和：用这一点Delta_Tau之前的值加上新值等于现在的信息素浓度
        end
	end
	Tau = (1-Rho) * Tau + Delta_Tau; %对信息素矩阵进行整体计算，减去挥发，加上新生成的信息素
    
    %% 显示此代信息
    fprintf('Iteration = %d, Min Distance = %.2f km  \n',Iter,MinDis(Iter))
    
    %% 更新迭代次数
	Iter = Iter + 1; %迭代次数加1
	%Pop = ones(AntNum,CityNum+2); %清空路径记录表
    
end

%% 找出历史最短距离和对应路径
mindisever = MinDis(MaxIter); % 取得历史最优适应值的位置、最优目标函数值
bestroute = bestind-1; % 取得最优个体

%% 计算结果数据输出到命令行
disp('-------------------------------------------------------------')
toc %显示运行时间
TextOutput(bestroute,mindisever)  %显示最优路径

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
