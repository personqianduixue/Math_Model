function route=InitPop(CityNum)
%% 初始化各粒子
%输入：
% Citynum   城市的个数
%输出：
% route      TSP路径

route=randperm(CityNum); %随机生成TSP路径