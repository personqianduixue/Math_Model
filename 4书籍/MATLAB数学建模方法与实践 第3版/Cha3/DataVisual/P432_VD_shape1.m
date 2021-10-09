% 数据可视化——数据分布形状图
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
% 读取数据
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
dv1=X(:,2);

% 绘制变量dv1的柱状分布图
h = -5:0.5:5;
n = hist(dv1,h);
figure
bar(h, n)

% 计算常用的形状度量指标
mn = mean(dv1); % 均值
sdev = std(dv1); % 标准差
mdsprd = iqr(dv1); % 四分位数
mnad = mad(dv1); % 中位数
rng = range(dv1); % 极差

% 标识度量数值
x = round(quantile(dv1,[0.25,0.5,0.75]));
y = (n(h==x(1)) + n(h==x(3)))/2;
line(x,[y,y,y],'marker','x','color','r')

x = round(mn + sdev*[-1,0,1]);
y = (n(h==x(1)) + n(h==x(3)))/2;
line(x,[y,y,y],'marker','o','color',[0 0.5 0])

x = round(mn + mnad*[-1,0,1]);
y = (n(h==x(1)) + n(h==x(3)))/2;
line(x,[y,y,y],'marker','*','color',[0.75 0 0.75])

x = round([min(dv1),max(dv1)]);
line(x,[1,1],'marker','.','color',[0 0.75 0.75])

legend('Data','Midspread','Std Dev','Mean Abs Dev','Range')
