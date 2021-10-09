function [Jb,center,U]=ObjFun(X,cn,V,options);
%% 计算种群中每个个体的目标值
% 输入
%        X：样本数据
%       cn：聚类数
%        V：所有的初始聚类中心矩阵
%  options：设置幂指数，最大迭代次数，目标函数的终止容限
% 输出
%    Jb：各个体的目标输出
% center：优化后的各个体的聚类中心
%      U：各样本的相似分类矩阵
[sizepop,m]=size(V);
ch=m/cn;
Jb=zeros(sizepop,1);
center=cell(sizepop,1);
U=cell(sizepop,1);
for i=1:sizepop
    v=reshape(V(i,:),cn,ch);
    [Jb(i),center{i},U{i}]=FCMfun(X,cn,v,options);
end