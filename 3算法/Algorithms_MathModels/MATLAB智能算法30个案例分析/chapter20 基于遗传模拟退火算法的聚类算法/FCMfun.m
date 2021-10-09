function [obj,center,U]=FCMfun(X,cluster_n,center,options)
%% FCM主函数
% 输入
%        X：样本数据
%cluster_n：聚类数
%   center：初始聚类中心矩阵
%  options：设置幂指数，最大迭代次数，目标函数的终止容限
% 输出
%    obj：目标输出Jb值
% center：优化后的聚类中心
%      U：相似分类矩阵
X_n=size(X,1);
in_n=size(X,2);
b=options(1);		    % 加权参数
max_iter=options(2);		% 最大迭代次数
min_impro=options(3);		% 相邻两次迭代最小改进（用来判断是否提前终止）
obj_fcn=zeros(max_iter,1);	% 初始化目标值矩阵
U = initFCM(X,cluster_n,center,b);			% 初始化聚类相似矩阵
% 主函数循环
for i = 1:max_iter,
    [U, center,obj_fcn(i)]=iterateFCM(X,U,cluster_n,b);
    % 核对终止条件
    if i > 1
        if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end,
    end
end
iter_n = i;	% 真实迭代次数
obj_fcn(iter_n+1:max_iter)=[];
obj=obj_fcn(end);


