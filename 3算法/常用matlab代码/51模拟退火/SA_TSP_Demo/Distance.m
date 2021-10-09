function D = Distance(citys)
%% 计算两两城市之间的距离
% 输入 citys  各城市的位置坐标
% 输出 D  两两城市之间的距离

n = size(citys,1);
D = zeros(n,n);
for i = 1:n
    for j = i+1:n
        D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));
        D(j,i) = D(i,j);
    end
end
