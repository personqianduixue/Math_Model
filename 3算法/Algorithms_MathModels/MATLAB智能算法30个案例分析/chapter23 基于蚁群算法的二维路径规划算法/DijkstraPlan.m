function path = DijkstraPlan(position,sign)
%% 基于Dijkstra算法的路径规划算法
%position    input     %节点位置
%sign        input     %节点间是否可达
 
%path        output    %规划路径
 
%% 计算路径距离
cost = ones(size(sign))*10000;
[n,m] = size(sign);
for i = 1:n
    for j = 1:m
        if sign(i,j) == 1
            cost(i,j) = sqrt(sum((position(i,:)-position(j,:)).^2));
        end
    end
end
 
%% 路径开始点
dist = cost(1,:);             %节点间路径长度           
s = zeros(size(dist));        %节点经过标志
s(1) = 1;dist(1) = 0;
path = zeros(size(dist));     %依次经过的节点
path(1,:) = 1;
 
%% 循环寻找路径点
for num = 2:n   
    
    % 选择路径长度最小点
    mindist = 10000;
    for i = 1:length(dist)
        if s(i) == 0
            if dist(i)< mindist
                mindist = dist(i);
                u = i;
            end
        end
    end
    
    % 更新点点间路径
    s(u) = 1;
    for w = 1:length(dist)
        if s(i) == 0
            if dist(u)+cost(u,w) < dist(w)
                dist(w) = dist(u)+cost(u,w);
                path(w) = u;
            end
        end
    end
end
