% 数据可视化——基本绘图
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
% 读取数据
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
% 绘制变量dv1的基本分布
N=size(X,1);
id=1:N;
figure
plot( id', X(:,2),'LineWidth',1)
set(gca,'linewidth',2);
xlabel('编号','fontsize',12);
ylabel('dv1', 'fontsize',12);
title('变量dv1分布图','fontsize',12);
% 同时绘制变量dv1-dv4的柱状分布图
figure
subplot(2,2,1);
hist(X(:,2));
title('dv1柱状分布图','fontsize',12)
subplot(2,2,2);
hist(X(:,3));
title('dv2柱状分布图','fontsize',12)
subplot(2,2,3);
hist(X(:,4));
title('dv3柱状分布图','fontsize',12)
subplot(2,2,4);
hist(X(:,5));
title('dv4柱状分布图','fontsize',12)
