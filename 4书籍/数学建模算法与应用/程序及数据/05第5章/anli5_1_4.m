clc,clear
load data3.txt  %把表5.8中的日期和时间数据行删除，余下的数据保存在纯文本文件
liu=data3([1,3],:); liu=liu'; liu=liu(:);  %提出水流量并按照顺序变成列向量
sha=data3([2,4],:); sha=sha'; sha=sha(:); %提出含沙量并按照顺序变成列向量
y=sha.*liu;   %计算排沙量，这里是列向量
format long e 
%以下是第一阶段的拟合
for j=1:2
nihe1{j}=polyfit(liu(1:11),y(1:11),j);%拟合多项式，系数排列从高次幂到低次幂
yhat1{j}=polyval(nihe1{j},liu(1:11));  %求预测值
%以下求误差平方和与剩余标准差
cha1(j)=sum((y(1:11)-yhat1{j}).^2); rmse1(j)=sqrt(cha1(j)/(10-j));
end
nihe1{:}  %显示细胞数组的所有元素
rmse1
%以下是第二阶段的拟合
for j=1:3
    nihe2{j}=polyfit(liu(12:24),y(12:24),(j+1)); %这里使用细胞数组
    yhat2{j}=polyval(nihe2{j},liu(12:24)); 
    rmse2(j)=sqrt(sum((y(12:24)-yhat2{j}).^2)/(11-j)); %求剩余标准差
end
nihe2{:}  %显示细胞数组的所有元素
rmse2
format  %恢复默认的短小数的显示格式
