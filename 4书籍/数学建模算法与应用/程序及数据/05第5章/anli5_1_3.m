clc,clear
load data3.txt  %把表5.8中的日期和时间数据行删除，余下的数据保存在纯文本文件
liu=data3([1,3],:); liu=liu'; liu=liu(:);  %提出水流量并按照顺序变成列向量
sha=data3([2,4],:); sha=sha'; sha=sha(:); %提出含沙量并按照顺序变成列向量
y=sha.*liu;   %计算排沙量，这里是列向量
subplot(1,2,1), plot(liu(1:11),y(1:11),'*')
subplot(1,2,2), plot(liu(12:24),y(12:24),'*')
