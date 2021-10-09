% grnn_test.m
%% 清理
close all
clear,clc

%% 训练数据
x=-9:8;
y=[129,-32,-118,-138,-125,-97,-55,-23,-4,...
    2,1,-31,-72,-121,-142,-174,-155,-77];
P=x;
T=y;

%% 设计网络与测试
xx=-9:.2:8;
yy = grnn_net(P,T,xx);

%% 显示
plot(x,y,'o')
hold on;
plot(xx,yy)
hold off


