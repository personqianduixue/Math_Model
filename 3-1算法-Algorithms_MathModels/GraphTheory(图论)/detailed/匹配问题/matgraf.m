function [ J ] = matgraf(W)
%图的一个较大基数匹配

n = size(W,1);
J = zeros(n,n);
while sum(sum(W)~=0)
    [x y] = find(W~=0);
    J(x(1),y(1))=1;J(y(1),x(1))=1;
    W(x(1),:)=0;W(y(1),:)=0;
    W(:,x(1))=0;W(:,y(1))=0;
end
end

