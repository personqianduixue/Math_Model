function U=initFCM(X,cluster_n,center,b)
%% 初始化相似分类矩阵
% 输入
%        X：样本数据
%cluster_n：聚类数
%   center：初始聚类中心矩阵
%        b：设置幂指数
% 输出
%      U：相似分类矩阵
dist=distfcm(center,X);       % 求出各样本与各聚类中心的距离矩阵
%% 计算新的U矩阵
tmp=dist.^(-2/(b-1));
U=tmp./(ones(cluster_n,1)*sum(tmp));