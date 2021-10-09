clc, clear
a=[15.2	 15.9	18.7	22.4	26.9	28.3	30.5
   33.8	 40.4	50.7	58	    66.7	81.2	83.4];
a=a'; a=a(:); a=a'; %把原始数据按照时间顺序展开成一个行向量
Rt=tiedrank(a)  %求原始时间序列的秩
n=length(a); t=1:n; 
Qs=1-6/(n*(n^2-1))*sum((t-Rt).^2)   %计算Qs的值
t=Qs*sqrt(n-2)/sqrt(1-Qs^2)   %计算T统计量的值
t_0=tinv(0.975,n-2)     %计算上alpha/2分位数
b=diff(a)   %求原始时间序列的一阶差分
m=ar(b,2,'ls')  %利用最小二乘法估计模型的参数
bhat=predict(m,[b'; 0],1)  %1步预测，样本数据必须为列向量,要预测1个值，b后要加1个任意数，1步预测数据使用到t-1步的数据
ahat=[a(1),a+bhat{1}']  %求原始数据的预测值，并计算t=15的预测值
delta=abs((ahat(1:end-1)-a)./a)  %计算原始数据预测的相对误差
xlswrite('yu.xls',ahat), xlswrite('yu.xls',delta,'Sheet1','A3') %数据写到Excel文件中，方便word中做表格贴入数据
