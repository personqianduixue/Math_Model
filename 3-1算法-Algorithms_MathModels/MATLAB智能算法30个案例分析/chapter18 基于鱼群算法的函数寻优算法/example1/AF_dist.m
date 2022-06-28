function D=AF_dist(Xi,X)
%计算第i条鱼与所有鱼的位置，包括本身。
%输入：
%Xi   第i条鱼的当前位置  
%X    所有鱼的当前位置
% 输出：
%D    第i条鱼与所有鱼的距离
col=size(X,2);
D=zeros(1,col);
for j=1:col
    D(j)=norm(Xi-X(:,j));
end
