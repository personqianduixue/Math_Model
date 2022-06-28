%计算第i条鱼与所有鱼的位置，包括本身。
function D=dist(Xi,X)
col=size(X,2);
D=zeros(1,col);
for j=1:col
    D(j)=norm(Xi-X(:,j));
end