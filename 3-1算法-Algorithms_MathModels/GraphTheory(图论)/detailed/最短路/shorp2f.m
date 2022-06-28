function [ p1 p2 d1 d2 ] = shorp2f(W,k1,k2)
% 图中两顶点间最短路与次短路的计算
% 首先，利用前面的算法求出k1、k2的最短路，不妨设此
% 最短路包含n条有向弧；然后，每次删去原权值矩阵W中
% 最短路中得边，从而得到n个矩阵与W只有一个元素的差别
% 的新权值矩阵，并对这n个权值矩阵分别求出最短路，从这
% n条最短路中选取最短，这样就求出了次短路.

[p1 d1] = n2shortf(W,k1,k2);
n = length(p1);
d2 = inf;
for i=1:(n-1)
    A = W;
    A(p1(i),p1(i+1))=inf;
    A(p1(i+1),p1(i))=inf;
    [m1 d]=n2shortf(A,k1,k2);
    if d<d2
        d2=d;
        p2=m1;
    end
end

end

