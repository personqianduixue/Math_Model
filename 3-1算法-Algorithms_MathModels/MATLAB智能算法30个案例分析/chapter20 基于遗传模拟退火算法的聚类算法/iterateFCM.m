function [U_new,center,obj_fcn]=iterateFCM(X,U,cluster_n,b)
%% 迭代
% 输入
%        X：样本数据
%        U：相似分类矩阵
%cluster_n：聚类数
%        b：幂指数
% 输出
%obj_fcn：当前目标输出Jb值
% center：新的的聚类中心
%  U_new：相似分类矩阵
mf=U.^b;       % 指数修正后的mf矩阵
center=mf*X./((ones(size(X,2),1)*sum(mf'))'); % 新的聚类中心
%% 目标值
dist=distfcm(center,X);       % 求出各样本与各聚类中心的距离矩阵
obj_fcn=sum(sum((dist.^2).*mf));  % 目标函数值
%% 计算新的U矩阵
tmp=dist.^(-2/(b-1));
U_new=tmp./(ones(cluster_n,1)*sum(tmp));
