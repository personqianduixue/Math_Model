function [P d]=cn2shorf(W,k1,k2,t1,t2)
% 必须通过指定的两个点的最短路
% function [P d]=cn2shorf(W,k1,k2,t1,t2)
% W 图的权值矩阵 k1 始点 k2 终点 t1 指定的点1 t2 指定的点2
% P 最终得到的路
% d 路的长度
% 路中的重复点记做一个点
[p1 d1]=n2shorf(W,k1,t1);  % 计算k1,t1之间的最短路
[p2 d2]=n2shorf(W,t1,t2);  % 计算t1,t2之间的最短路
[p3 d3]=n2shorf(W,t2,k2);  % 计算t2,k2之间的最短路
dt1=d1+d2+d3;
[p4 d4]=n2shorf(W,k1,t2);  % 计算k1,t2之间的最短路
[p5 d5]=n2shorf(W,t2,t1);  % 计算t2,t1之间的最短路
[p6 d6]=n2shorf(W,t1,k2);  % 计算t1,k2之间的最短路
dt2=d4+d5+d6;
% 比较两个和值
if dt1<dt2
    d=dt1;
    P=[p1 p2(2:length(p2)) p3(2:length(p3))];
else 
    d=dt2;
    P=[p4 p5(2:length(p5)) p6(2:length(p6))];
end
P;
d;