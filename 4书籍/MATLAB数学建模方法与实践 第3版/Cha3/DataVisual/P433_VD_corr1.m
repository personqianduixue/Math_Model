% 数据可视化——变量想相关性
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
% 读取数据
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
Vars = X(:,7:12);
%  绘制变量间相关性关联图
figure
plotmatrix(Vars)
%  绘制变量间相关性强度图
covmat = corrcoef(Vars);
figure
imagesc(covmat);
grid;
colorbar;