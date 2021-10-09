function ttlDistance=CalcDis(route,Distance)
%% 计算各个体的路径长度 适应度函数  
%输入：
%route          某粒子代表的路径
%Distance       两两城市之间的距离矩阵

%输出：
%ttlDistance	种群个体路径距离

col=size(Distance,2); %col列数=配送中心+需求点数

i1=route(1:end-1); %计算每两点间距离的前一个点的编号
i2=route(2:end); %计算每两点间距离的后一个点的编号

ttlDistance=sum(Distance(i1+i2*col+1)); %矩阵中这些每两点间距离之和