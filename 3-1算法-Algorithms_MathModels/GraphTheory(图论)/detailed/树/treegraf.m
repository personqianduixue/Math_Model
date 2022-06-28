function [ W ] = treegraf( G)
% 求无向图的生成树
n = size(G,1);
W = zeros(n,n);
C = zeros(1,n);
C(1)=1;
for i = 1:n-1
    [a b] = find(G(C(1:i),:)~=0);
    W(C(a(1)),b(1))=1;
    W(b(1),C(a(1)))=1;
    C(i+1)=b(1);
    G(C(1:(i+1)),C(1:(i+1)))=0;
end


end

