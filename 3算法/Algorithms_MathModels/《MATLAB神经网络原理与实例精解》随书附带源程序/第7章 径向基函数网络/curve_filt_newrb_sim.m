% curve_filt_newrb_sim.m

%% 原始训练数据
x=-9:8;
y=[129,-32,-118,-138,-125,-97,-55,-23,-4,...
    2,1,-31,-72,-121,-142,-174,-155,-77];

%% 测试
% 测试数据
xx=-9:.2:8;

% 加载训练模型  上一步训练得到的net保存在example.mat中
load curve_filt_newrb_build.mat

% 网络仿真
yy = sim(net, xx);

%%绘图
% 原数据点
figure;
plot(x,y,'o');
hold on;
% 仿真得到的拟合数据
plot(xx,yy,'-');
hold off;

% 图例、标题
legend('原始数据','拟合数据');
title('用径向基函数拟合曲线');
