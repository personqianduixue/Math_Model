function [S,R]=Metropolis(S1,S2,D,T)
%% 输入
% S1：  当前解
% S2:   新解
% D:    距离矩阵（两两城市的之间的距离）
% T:    当前温度
%% 输出
% S：   下一个当前解
% R：   下一个当前解的路线距离
%%
R1=PathLength(D,S1);  %计算路线长度
N=length(S1);         %得到城市的个数

R2=PathLength(D,S2);  %计算路线长度
dC=R2-R1;   %计算能力之差
if dC<0       %如果能力降低 接受新路线
    S=S2;
    R=R2;
elseif exp(-dC/T)>=rand   %以exp(-dC/T)概率接受新路线
    S=S2;
    R=R2;
else        %不接受新路线
    S=S1;
    R=R1;
end