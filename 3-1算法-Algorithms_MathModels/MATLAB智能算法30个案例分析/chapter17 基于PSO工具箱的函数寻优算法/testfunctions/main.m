%% 基于粒子群工具箱的函数优化算法

%% 清空环境
clear
clc

%% 参数初始化
x_range=[-50,50];     %参数x变化范围
y_range=[-50,50];     %参数y变化范围
range = [x_range;y_range];     %参数变化范围(组成矩阵)
Max_V = 0.2*(range(:,2)-range(:,1));  %最大速度取变化范围的10%~20%
n=2;                     %待优化函数的维数，此例子中仅x、y两个自变量，故为2

PSOparams= [25 2000 24 2 2 0.9 0.4 1500 1e-25 250 NaN 0 0];

%% 粒子群寻优
pso_Trelea_vectorized('Rosenbrock',n,Max_V,range,0,PSOparams)  %调用PSO核心模块