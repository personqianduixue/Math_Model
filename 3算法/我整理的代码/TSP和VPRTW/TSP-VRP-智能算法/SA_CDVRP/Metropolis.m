function [S,ttlDis]=Metropolis(S1,S2,Distance,Demand,Travelcon,Capacity,T)
%% 输入
% S1        当前解
% S2        新解
% Distance  距离矩阵（两两城市的之间的距离）
% Demand        各点需求量
% Travelcon     行程约束
% Capacity      容量约束
% T         当前温度
%% 输出
% S         下一个当前解
% ttlDis	下一个当前解的路线距离

%%
ttlDis1 = Evaluation(S1,Distance,Demand,Travelcon,Capacity);  %计算路线长度
ttlDis2 = Evaluation(S2,Distance,Demand,Travelcon,Capacity);  %计算路线长度
dC = ttlDis2 - ttlDis1;   %计算路线长度之差

if dC < 0       %如果能力降低 接受新路线
    S = S2;
    ttlDis = ttlDis2;
elseif exp(-dC/T) >= rand   %以exp(-dC/T)概率接受新路线
    S = S2;
    ttlDis = ttlDis2;
else  %不接受新路线
    S = S1;
    ttlDis = ttlDis1;
end