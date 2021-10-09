function [nextroad,nextdistance,nextstate]=nextdir_red(cari,RoadMap,Car,Roaddistance,Outroad, RoadCarNum)
%% 函数nextdir返回cari这辆车这一秒之后的状态
%Input arguments：
%                cari：1 x 1 int 车的序号
%                RoadMap: n x n array 路的可达性矩阵
%                Car：n x 1 cell 当前各辆车的状态
%                Roaddistance：n x 1 int 每条路的长度
%                Outroad：k x 1 int 所有可能出去的路 k是出口数
%                RoadCarNum: n x 1 int 当前每条路上有多少车
%Output arguments:
%                nextroad: 1 x 1 int 1s后所在的路
%                nextdistance：1 x 1 int 1s后在路上距路入口的逻辑距离
%                nextstate: 1 x 1 int dual value(0,1)1s后，该车是否还在区域内
%% 
    car = Car{cari}; % 当前正在考虑的车
    nextstate = 1;
    nextroad = car.road;
    nextdistance = car.distance;
    if car.distance >= Roaddistance(Car{cari}.road) && ismember(car.road,Outroad);
        return;
    end
    nextdistance = nextdistance + 1;
    if(Roaddistance(nextroad) < nextdistance)
        nextroad = chooseRoad(cari,nextroad,RoadMap,Car,Roaddistance, RoadCarNum); %%%交叉路口选择路的方向
        nextdistance = 1;
    end
    for i = 1 : (cari - 1)
           if(Car{i}.state == 1 && Car{i}.road == nextroad && Car{i}.distance == nextdistance)
               % 车辆不能走，
               nextroad = car.road;
               nextdistance = car.distance;
           end
    end
    