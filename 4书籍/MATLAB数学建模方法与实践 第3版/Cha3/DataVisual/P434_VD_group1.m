% 数据可视化——数据分组
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
% 读取数据
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
dv1=X(:,2);
eva=X(:,12);
% Boxplot
figure
boxplot(X(:,2:12))
figure
boxplot(dv1, eva)
figure
boxplot(X(:,5))
