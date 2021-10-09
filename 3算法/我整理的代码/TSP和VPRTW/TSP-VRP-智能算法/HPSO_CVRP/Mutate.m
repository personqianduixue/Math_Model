function route=Mutate(route)
%% 变异操作
%输入：
%route  某粒子代表的路径

%输出：
%route	变异后的粒子代表的路径

RandIndex = randperm(length(route)-2)+1; %除去染色体首尾配送中心位后再突变

route(RandIndex(2:-1:1)) = route(RandIndex(1:2)); %换位变异
route(RandIndex(4:-1:3)) = route(RandIndex(3:4)); %二次换位变异