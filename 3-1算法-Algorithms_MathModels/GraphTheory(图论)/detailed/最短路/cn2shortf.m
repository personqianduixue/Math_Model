function [ Path Dist ] = cn2shortf( W,k1,k2,t1,t2 )
%  必须通过两个指定顶点t1、t2的最短路径
% 该算法有问题：路径中有可能会出现k2点,该算法不可用!!


[p1 d1] = n2shortf(W,k1,t1);    %计算k1、t1之间的最短距离
[p2 d2] = n2shortf(W,t1,t2);    %计算t1、t2之间的最短距离
[p3 d3] = n2shortf(W,t2,k2);    %计算t2、k2之间的最短距离
dt1=d1+d2+d3;
[p4 d4] = n2shortf(W,k1,t2);    %计算k1、t2之间的最短距离
[p5 d5] = n2shortf(W,t2,t1);    %计算t2、t1之间的最短距离
[p6 d6] = n2shortf(W,t1,k2);    %计算t2、k2之间的最短距离
dt2=d4+d5+d6;

if dt1 < dt2
    Dist = dt1;
    Path=[p1,p2(2:length(p2)),p3(2:length(p3))];
else
    Dist = dt2;
    Path=[p4,p5(2:length(p5)),p6(2:length(p6))];
end

end

