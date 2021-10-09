function [ W ] = BFS(G,start)
%广度优先搜索
n = size(G,1);
W = zeros(1,n);
visited = zeros(1,n);
Gx = G;
% queue用来模仿队列
queue = start;
visited(start) = 1;
count = 0;
W(queue) = count;
count = count+1;
while ~isempty(queue)
    [m n] = find(Gx(queue,:)~=0);
    n=unique(n);
    queue = setdiff(n,find(visited==1));
    visited(queue)=1;
    W(queue) = count;
    count = count + 1;
end
end

