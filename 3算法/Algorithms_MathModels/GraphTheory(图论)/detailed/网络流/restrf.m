function f = restrf(W,dx,dy)
% 有供需约束的可行流
% W表示网络的容量矩阵
% dx表示源的容量限制
% dy表示汇的需求量
s = size(W,1);
k  = 1;l = 1;
for i = 1:s
    if sum(W(i,:))~=0 && sum(W(:,i))==0
        X(k)=i;
        k=k+1;
    end
    if sum(W(i,:))==0 && sum(W(:,i))~=0
        Y(l)=i;
        l=l+1;
    end 
end
m = length(X);
n = length(Y);
x = zeros(1,s);
W1=[0 x 0;x' W x';0 x 0];
for i = 1:m
    W1(1,X(i)+1)=dx(i);
end
for j = 1:n
    W1(Y(j)+1,s+2)=dy(j);
end
[f1 wf]=fofuf(W1);
if wf < sum(W1(:,s+2))
    f = 0;
else
    f = f1(2:(s+1),2:(s+1));
end




end

