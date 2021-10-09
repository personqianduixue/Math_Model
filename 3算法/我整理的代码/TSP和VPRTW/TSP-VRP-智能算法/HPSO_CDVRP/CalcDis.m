function ttlDistance=CalcDis(route,Distance,Demand,Travelcon,Capacity)
%% 计算各个体的路径长度 适应度函数  
%输入：
%route          某粒子代表的路径
%Distance       两两城市之间的距离矩阵
%Demand         各点需求量
%Travelcon      行程约束
%Capacity       容量约束

%输出：
%ttlDistance	种群个体路径距离

%相关数据初始化
DisTraveled=0;  % 汽车已经行驶的距离
delivery=0; % 汽车已经送货量，即已经到达点的需求量之和
Dis=0; %此方案所有车辆的总距离

for j=2:length(route)
	DisTraveled = DisTraveled+Distance(route(j-1),route(j)); %每两点间距离累加
	delivery = delivery+Demand(route(j)); %累加可配送量
	if DisTraveled > Travelcon || delivery > Capacity
        Dis = Inf;  %对非可行解进行惩罚
        break
    end
	if route(j)==1 %若此位是配送中心
        Dis=Dis+DisTraveled; %累加已行驶距离
        DisTraveled=0; %已行驶距离置零
        delivery=0; %已配送置零
	end
end
ttlDistance=Dis; %存储此方案总距离