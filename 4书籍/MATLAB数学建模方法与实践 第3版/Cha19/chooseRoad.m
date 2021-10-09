function [nextroad] = chooseRoad(cari,currentRoad, RoadMap,Car,Roaddistance, RoadCarNum)
%% function [nextroad] = chooseRoad(cari,currentRoad, RoadMap,Car,Roaddistance, RoadCarNum)
%Input arguments：
%               cari：1 x 1 int  车的序号
%               currentRoad:1 x 1 int 当前所在的路的标号
%               RoadMap: n x n array 路的可达性矩阵
%               Car：n x 1 cell 当前各辆车的状态
%               Roaddistance：n x 1 int 每条路的长度
%               RoadCarNum: n x 1 int 当前每条路上有多少车
%Output arguments：
%               nextroad: 1 x 1 int 选择的下一条路的标号
%%
k1 = 1;%两个参数
k2 = 1;
nextroad = 0;
min = intmax();
roadNum = length(RoadMap);
% disp(strcat('currentroadNum', num2str(currentRoad)));
myNeighbor = zeros(roadNum);
myNeighborNum = 0;
for i = 1 : roadNum
    if(RoadMap(i, currentRoad) == 0) %道路不通的情况
        continue;
    end
    myNeighborNum = myNeighborNum + 1;
    myNeighbor(myNeighborNum) = i;
    % disp(strcat('roadNum', num2str(i)));
    
    % 根据最优选择
    myvalue = 0;
    for j = 1 : (cari - 1)
        if(Car{j}.state == 1 && Car{j}.road == i && Car{j}.distance == 1)
            %判断走这条路是否需要等
            myvalue = intmax() - 100000;
            break;
        end
    end
    %计算每条路的指标
    myvalue = myvalue + k1 * Roaddistance(i) + k2 * RoadCarNum(i);
    
    if(myvalue < min)
        min = myvalue;
        nextroad = i;
    end
    
    %     disp(i);
    %    disp(myvalue);
    
end
% 随即选择
% nextroad = myNeighbor(ceil(rand() * (myNeighborNum - 1)) + 1);


