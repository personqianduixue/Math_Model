%% 加权移动平均法
clc ,clear

y = [6.35 6.20 6.22 6.66 7.15 7.89 8.72 8.94 9.28 9.80];
w = [1/6; 2/6; 3/6];   % 各加权项的权重
m = length(y);
n = 3;                 % 移动平均的项数
for i = 1:m-n+1
    yhat(i) = y(i:i+n-1)*w;
end
err = abs(y(n+1:m)-yhat(1:end-1))./y(n+1:m);  % 计算相对误差(最开始的三项数据是没有相对误差的)
T_err = 1 - sum(yhat(1:end-1))/sum(y(n+1:m)); % 计算总的相对误差
y_predict = yhat(end) / (1-T_err);            % 用总的相对误差修正预测值