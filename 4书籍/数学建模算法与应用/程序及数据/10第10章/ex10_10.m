clc,clear
r=[1 1/5 -1/5;1/5 1 -2/5;-1/5 -2/5 1];
%下面利用相关系数矩阵求主成分解，val的列为r的特征向量，即主成分的系数
[vec,val,con]=pcacov(r) %val为r的特征值，con为各个主成分的贡献率
num=input('请选择公共因子的个数：');  %交互式选取主因子的个数
f1=repmat(sign(sum(vec)),size(vec,1),1);
vec=vec.*f1;     %特征向量正负号转换
f2=repmat(sqrt(val)',size(vec,1),1);
a=vec.*f2   %计算因子载荷矩阵
aa=a(:,1:num)   %提出两个主因子的载荷矩阵
s1=sum(aa.^2)   %计算对X的贡献率，实际上等于对应的特征值
s2=sum(aa.^2,2)  %计算共同度
