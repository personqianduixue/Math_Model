%% 一元线性回归实例
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 输入数据
clc, clear all, close all
x=[23.80,27.60,31.60,32.40,33.70,34.90,43.20,52.80,63.80,73.40];
y=[41.4,51.8,61.70,67.90,68.70,77.50,95.90,137.40,155.0,175.0];	
%% 采用最小二乘回归
% 绘制散点图，判断是否具有线性关系
figure
plot(x,y,'r*')                         %作散点图
xlabel('x（职工工资总额）','fontsize', 12)           %横坐标名
ylabel('y（商品零售总额）', 'fontsize',12)           %纵坐标名
set(gca,'linewidth',2);
% 采用最小二乘拟合
Lxx=sum((x-mean(x)).^2);
Lxy=sum((x-mean(x)).*(y-mean(y)));
b1=Lxy/Lxx;
b0=mean(y)-b1*mean(x);
y1=b1*x+b0;
hold on
plot(x, y1,'linewidth',2);

%% 采用LinearModel.fit函数进行回归
m2 = LinearModel.fit(x,y)

%% 采用regress函数进行回归
Y=y';
X=[ones(size(x,2),1),x'];
[b, bint, r, rint, s] = regress(Y, X)