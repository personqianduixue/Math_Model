%% 1、随机产生初始聚类中心
% clc;
clear
%% 加载数据
load X
figure
plot(X(:,1),X(:,2),'o')
xlabel('横坐标X');ylabel('纵坐标Y');title('样本数据')
hold on
%% 进行模糊C均值聚类
% 设置幂指数为3，最大迭代次数为20，目标函数的终止容限为1e-6
options=[3,20,1e-6,0];
% 调用fcm函数进行模糊C均值聚类，返回类中心坐标矩阵center，隶属度矩阵U，目标函数值obj_fcn
cn=4; %聚类数
[center,U,obj_fcn]=fcm(X,cn,options);
Jb=obj_fcn(end)
maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2, :) == maxU);
index3 = find(U(3, :) == maxU);
%% 分类情况
% 在前三类样本数据中分别画上不同记号 不加记号的就是第四类了
line(X(index1,1), X(index1, 2), 'linestyle', 'none', 'marker', 'x', 'color', 'g'); 
line(X(index2,1), X(index2, 2), 'linestyle', 'none', 'marker', '*', 'color', 'r');
line(X(index3,1), X(index3, 2), 'linestyle', 'none', 'marker', '+', 'color', 'b');
%% 画出聚类中心
plot(center(:,1),center(:,2),'v')
hold off