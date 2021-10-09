clc,clear
load data3.txt  %把表5.8中的日期和时间数据行删除，余下的数据保存在纯文本文件
liu=data3([1,3],:); liu=liu'; liu=liu(:);  %提出水流量并按照顺序变成列向量
sha=data3([2,4],:); sha=sha'; sha=sha(:); %提出含沙量并按照顺序变成列向量
y=sha.*liu; y=y';  %计算排沙量，并变成行向量
i=1:24;
t=(12*i-4)*3600;
t1=t(1);t2=t(end);
pp=csape(t,y); %进行三次样条插值
xsh=pp.coefs  %求得插值多项式的系数矩阵，每一行是一个区间上多项式的系数。
TL=quadl(@(tt)ppval(pp,tt),t1,t2)   %求总含沙量的积分运算
