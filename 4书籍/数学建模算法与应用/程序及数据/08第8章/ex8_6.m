clc, clear
format long g
a=load('jijie.txt');
[m,n]=size(a);
a_mean=mean(mean(a));  %计算所有数据的算术平均值
aj_mean=mean(a);  %计算同季节的算术平均值
bj=aj_mean/a_mean  %计算季节系数
w=1:m;
yhat=w*sum(a,2)/sum(w)  %预测下一年的年加权平均值,这里是求行和
yjmean=yhat/n  %计算预测年份的季节平均值
yjhat=yjmean*bj  %预测年份的季节预测值
format   %恢复默认的显示格式
