function clas = pnn_net(p,t,x,sigma)
% pnn_net.m
% p为训练输入,R*Q，Q个长度为R的向量
% t为训练输出,1*Q行向量，取值从1~C，表示C个类别，C<=Q
% x为测试输入,R*S矩阵，S个长度为R的列向量

% 
if ~exist('sigma','var')
    sigma=0.1;
end

% 数据归一化
MAX = max(p(:));
p=p/MAX;
x=x/MAX;

% 向量长度M，向量个数N
[R,Q]=size(p);
[R,S]=size(x);

% 计算径向基层的输出,y(i,j)是第j个测试向量与第i个神经元的输出
y=zeros(Q,S);
for i=1:S
    for j=1:Q
        v = norm((x(:,i) - p(:,j))); %' * (x(:,i) - p(:,j));
        y(j,i) = exp(-v^2/(2*sigma^2));
    end
end

% 相加层
% 共有C个类别
C = length(unique(t));
% 相加层输出
vc=zeros(C,S);
for i=1:C
    for j=1:S
        vc(i,j) = mean(y(t==i,j));
    end
end

% 输出层
yout=zeros(C,S);
for i=1:S
    [~,index] = max(vc(:,i));
    yout(index,i) = 1;
end

clas=vec2ind(yout);
