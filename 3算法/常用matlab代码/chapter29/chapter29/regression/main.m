%% 极限学习机在回归拟合问题中的应用研究

%% 清空环境变量
clear all
clc

%% 导入数据
load data
% 随机生成训练集、测试集
k = randperm(size(input,1));
% 训练集——1900个样本
P_train=input(k(1:1900),:)';
T_train=output(k(1:1900));
% 测试集——100个样本
P_test=input(k(1901:2000),:)';
T_test=output(k(1901:2000));

%% 归一化
% 训练集
[Pn_train,inputps] = mapminmax(P_train,-1,1);
Pn_test = mapminmax('apply',P_test,inputps);
% 测试集
[Tn_train,outputps] = mapminmax(T_train,-1,1);
Tn_test = mapminmax('apply',T_test,outputps);

tic
%% ELM创建/训练
[IW,B,LW,TF,TYPE] = elmtrain(Pn_train,Tn_train,20,'sig',0);

%% ELM仿真测试
Tn_sim = elmpredict(Pn_test,IW,B,LW,TF,TYPE);
% 反归一化
T_sim = mapminmax('reverse',Tn_sim,outputps);

toc
%% 结果对比
result = [T_test' T_sim'];
% 均方误差
E = mse(T_sim - T_test)
% 决定系数
N = length(T_test);
R2 = (N*sum(T_sim.*T_test)-sum(T_sim)*sum(T_test))^2/((N*sum((T_sim).^2)-(sum(T_sim))^2)*(N*sum((T_test).^2)-(sum(T_test))^2))

%% 绘图
figure
plot(1:length(T_test),T_test,'r*')
hold on
plot(1:length(T_sim),T_sim,'b:o')
xlabel('测试集样本编号')
ylabel('测试集输出')
title('ELM测试集输出')
legend('期望输出','预测输出')

figure
plot(1:length(T_test),T_test-T_sim,'r-*')
xlabel('测试集样本编号')
ylabel('绝对误差')
title('ELM测试集预测误差')

