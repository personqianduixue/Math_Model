%% 绘制蚁群算法中蚂蚁数目与最短路程、收敛迭代次数、程序执行时间关系图
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 准备环境与数据
clc
clear 

% 输入数据
R=[0.6	0.8	1 1.2 1.4 1.6 1.8 2];
Y1=[7652	7718	7710	7760	7674	7696	7675	7681];
Y2=[64	59	67	60	48	66	55	81];
Y3=[21	27	33	39	46	52	58	66];

%% 绘图
set(gca,'linewidth',2) 
% 与最短路程关系图
subplot(3,1,1);
plot(R,Y1, '-r*', 'LineWidth', 2);
set(gca,'linewidth',2);       % 设置坐标轴线宽
xlabel('蚂蚁数与城市数之比');
ylabel('最短路程');
title('蚂蚁数与最短路程关系图','fontsize',12);
% legend('最短路程');

% 与收敛迭代次数关系
subplot(3,1,2);
plot(R,Y2, '--bs', 'LineWidth', 2);
set(gca,'linewidth',2) ;
xlabel('蚂蚁数与城市数之比','LineWidth', 2);
ylabel('收敛迭代次数', 'LineWidth', 2);
title('蚂蚁数与收敛迭代次数关系图','fontsize',12);
% legend('收敛迭代次数');

% 与程序执行时间关系
subplot(3,1,3);
plot(R,Y3, '-ko', 'LineWidth', 2);
set(gca,'linewidth',2) ;
xlabel('蚂蚁数与城市数之比');
ylabel('执行时间');
title('蚂蚁数与执行时间关系图','fontsize',12);
% legend('执行时间');
