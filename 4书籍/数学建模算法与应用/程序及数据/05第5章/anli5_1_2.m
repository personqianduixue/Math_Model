clc,clear
load data3.txt  %把表5.8中的日期和时间数据行删除，余下的数据保存在纯文本文件
liu=data3([1,3],:); liu=liu'; liu=liu(:);  %提出水流量并按照顺序变成列向量
sha=data3([2,4],:); sha=sha'; sha=sha(:); %提出含沙量并按照顺序变成列向量
y=sha.*liu; y=y';  %计算排沙量，并变成行向量
i=1:24;
t=(12*i-4)*3600;
t1=t(1);t2=t(end);
pp=spapi(4,t,y)      %三次B样条
pp2=fn2fm(pp,'pp')  %把B样条函数转化为pp格式
TL=quadl(@(tt)fnval(pp,tt),t1,t2)
