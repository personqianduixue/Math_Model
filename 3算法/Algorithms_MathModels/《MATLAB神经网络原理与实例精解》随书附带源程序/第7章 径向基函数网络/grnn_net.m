function y = grnn_net(p,t,x,spread)
% grnn_net.m
% p：R*Q矩阵，包含Q个长度为R的输入
% t：1*Q行向量，对应于p的期望输出
% spread：平滑因子，可选，缺省值为0.5

if ~exist('spread','var')
    spread=0.5;
end

[R,Q]=size(p);
[R,S]=size(x);

%% 径向基层的输出
yr = zeros(Q,S);
for i=1:S
    for j=1:Q
        v = norm(x(:,i) - p(:,j));
        yr(j,i) = exp(-v.^2/(2*spread.^2));
    end
end

%% 加和层的输出
ya = zeros(2,S);
for i=1:S
    ya(1,i) = sum(t .* yr(:,i)',2);
    ya(2,i) = sum(yr(:,i));
end

%% 输出层的结果
y = ya(1,:)./(eps+ya(2,:));
