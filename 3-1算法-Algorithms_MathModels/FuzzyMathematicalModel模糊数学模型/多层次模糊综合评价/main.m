%%多层次模糊综合评价案例
clc, clear

load data.txt
sj = [repmat(data(:,1),1,3), data(:,2:end)];   % 将第一列的成绩值也采用同样的方式扩展
% 此时数据一列为一个指标，一行为一个样本

% 归一化处理
n = size(sj,2)/3;
m = size(sj,1);
w = [0.5*ones(1,3), 0.125*ones(1,12)];         % 五项指标的权重向量(5x3)
w = repmat(w,m,1);
y = [];
for i = 1:n
    tm = sj(:,3*i-2:3*i);
    max_t = max(tm);
    max_t = repmat(max_t, m, 1);
    max_t = max_t(:,3:-1:1);
    yt = tm./max_t;
    yt(:,3) = min([yt(:,3)'; ones(1,m)]);
    y = [y,yt];
end

% 求解模糊决策矩阵
r = [];
for i = 1:n
    tm1 = y(:,3*i-2:3*i);
    tm2 = w(:,3*i-2:3*i);
    r = [r, tm1.*tm2];
end

% 求M+和M-的距离
m_plus = max(r);
m_minus = min(r);
d_plus = dist(m_plus,r');
d_minus = dist(m_minus,r');

% 求隶属度
mu = d_minus./(d_minus+d_plus);
[mu_sort, ind] = sort(mu, 'descend')
