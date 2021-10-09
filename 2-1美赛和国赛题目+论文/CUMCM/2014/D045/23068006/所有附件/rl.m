function [dd,d]=rl(B)%%%%%%B 表示renyiryd的结果,dd 是排序后的结果
[m,n]=size(B);

d=tabulate(B(:,2));
d=d(10:end,:);         %%%%%累计贡献率数据

dd=sortrows(d,3);
