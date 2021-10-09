function Length = PathLength(D,Route)
%% 计算各个体的路径长度
% 输入：
% D     两两城市之间的距离
% Route 个体的轨迹

Length = 0;
n = size(Route,2);
for i = 1:(n - 1)
    Length = Length + D(Route(i),Route(i + 1));
end
Length = Length + D(Route(n),Route(1));

