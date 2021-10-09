function ttlDistance=CalcDis(route,Distance,TravelTime,Demand,TimeWindow,Travelcon,Capacity)
%% 计算各个体的路径长度 适应度函数  
%输入：
%route          某粒子代表的路径
%Distance       两两城市之间的距离矩阵
%TravelTime    行驶时间矩阵
%Demand         各点需求量
%TimeWindow    早晚时间窗
%Travelcon      行程约束
%Capacity       容量约束

%输出：
%ttlDistance	种群个体路径距离

%相关数据初始化
Dis=0; %此方案所有车辆的总距离置零
DisTraveled=0;  % 所有车辆已经行驶的距离置零
CurrentTime=0; % 所有车辆行驶时间置零
delivery=0; % 所有车辆已经送货量，即已经到达点的需求量之和


for j=2:length(route)
    DisTraveled = DisTraveled+Distance(route(j-1),route(j)); %每两点间距离累加
    if route(j) == 1  %若此点是配送中心

        if DisTraveled > Travelcon
            Dis = Inf;  %对非可行解进行惩罚
            break
        else
            Dis=Dis+DisTraveled; %累加已行驶距离
            DisTraveled=0; %已行驶距离置零
            CurrentTime=0; %时间置零TimeWindow(1,2)
            delivery=0; %可配送量置零
        end
    else %若此点非配送中心
        if DisTraveled > Travelcon
            Dis = Inf;  %对非可行解进行惩罚
            break
        else
            delivery = delivery+Demand(route(j)); %累加可配送量
            if delivery > Capacity
                Dis = Inf; %对非可行解进行惩罚
                break
            else
                CurrentTime = CurrentTime + TravelTime(route(j-1),route(j));
                if CurrentTime > TimeWindow(route(j),2) %将晚时间窗是否超约束放到route(j)是否=1外判断，防止route(j)=1时TW=0始终超约束的错误判断，这一步也是为什么要将route(j)是否为1分开判断的原因
                    Dis = Inf;  %对非可行解进行惩罚
                    break
                else
                    CurrentTime = max(CurrentTime,TimeWindow(route(j),1));%若到达时间早于早时间窗，等待至早时间窗
                end
            end
        end
    end
end
ttlDistance=Dis; %存储此VRP路径总距离