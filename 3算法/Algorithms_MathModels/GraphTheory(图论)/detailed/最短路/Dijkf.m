function [d path] = Dijkf(W,start)
% Dijkstra算法，求取初始点到其他所有点的最短路径
% input arg:W是图的权值矩阵，start是初始点的标号，从1开始
% d表示最短距离的值，path是路径矩阵

% 参数初始化
path=zeros(length(W),length(W));
path(:,1)=start;
d(1:length(W)) = W(start,:);
d(start)=0;
visited(1:length(W)) =0;
visited(start) =1;
while sum(visited) < length(W)
%     找到未访问的节点
    tb = find(visited == 0);
%     找到未访问节点中距离初始点距离最短的节点
    tmpb = find(d(tb) == min(d(tb)));
    tmpb = tb(tmpb(1));
%     标记为已访问状态
    visited(tmpb) = 1;
%     更新其他的节点
    tb = find(visited == 0);
    tx = find(d(tb) > d(tmpb) + W(tmpb,tb));
    tb = tb(tx);
    d(tb) = d(tmpb) + W(tmpb,tb); 
%     更新path值
     for i = 1:length(tb)
        path(tb(i),:) = path(tmpb,:);
        x = find(path(tb(i),:)==0);
        path(tb(i),x(1))=tmpb;
        path(tb(i),x(2))=tb(i);
     end
end
% 求解过程结束
end

