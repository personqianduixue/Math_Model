%% 简单移动平均法
clc, clear

y = [533.8 574.6 606.9 649.8 705.1 772.0 816.4 892.7 963.9 1015.1 1102.7];
m = length(y);
n = [4,5];    % n位移动平均的项数，选取4和5分别做一次运算
for i = 1:length(n)
    for j = 1:m-n(i)+1
        yhat{i}(j) = sum(y(j:j+n(i)-1))/n(i);
    end
    y_predict(i) = yhat{i}(end);  % 预测值
    s(i) = sqrt(mean( (y(n(i)+1:m) - yhat{i}(1:end-1)).^2 )); % 预测的标准误差
end
