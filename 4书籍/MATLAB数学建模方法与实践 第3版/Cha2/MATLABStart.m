% MATLAB 入门案例
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 导入数据
clc, clear, close all
% 导入数据
[~, ~, raw] = xlsread('sz000004.xls','Sheet1','A2:H99');

% 创建输出变量
data = reshape([raw{:}],size(raw));

% 将导入的数组分配给列变量名称
Date = data(:,1);
DateNum = data(:,2);
Popen = data(:,3);
Phigh = data(:,4);
Plow = data(:,5);
Pclose = data(:,6);
Volum = data(:,7);
Turn = data(:,8);
% 清除临时变量
 clearvars data raw;

 %% 数据探索
figure % 创建一个新的图像窗口
plot(DateNum,Pclose,'k') % 更改图的的颜色的黑色(打印后不失真)
datetick('x','mm');% 更白日期显示类型
xlabel('日期'); % x轴说明
ylabel('收盘价'); % y轴说明
figure
bar(Pclose) % 作为对照图形

%% 股票价值的评估
p = polyfit(DateNum,Pclose,1); % 多项式拟合,
% 分号作用为不在命令窗口显示执行结果
P1 = polyval(p,DateNum); % 得到多项式模型的结果
figure
plot(DateNum,P1,DateNum,Pclose,'*g'); % 模型与原始数据的对照
value = p(1) % 将斜率赋值给value， 作为股票的价值。
 
%% 股票风险的评估
MaxDD = maxdrawdown(Pclose); % 计算最大回撤
risk = MaxDD  % 将最大回撤赋值给risk， 作为股票的风险