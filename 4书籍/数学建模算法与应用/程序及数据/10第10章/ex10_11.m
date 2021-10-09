clc,clear
r=[1 1/5 -1/5;1/5 1 -2/5;-1/5 -2/5 1];
n=size(r,1); rt=abs(r); %求矩阵r所有元素的绝对值
rt(1:n+1:n^2)=0; %把rt矩阵的对角线元素换成0
rstar=r; %R*初始化
rstar(1:n+1:n^2)=max(rt'); %把矩阵rstar的对角线元素换成rt矩阵各行的最大值 
%下面利用R*矩阵求主因子解，vec1的列为矩阵rstar的特征向量
[vec1,val,rate]=pcacov(rstar)  %val为rstar的特征值，rate为各个主成分的贡献率
f1=repmat(sign(sum(vec1)),size(vec1,1),1);
vec2=vec1.*f1     %特征向量正负号转换
f2=repmat(sqrt(val)',size(vec2,1),1);
a=vec2.*f2   %计算因子载荷矩阵
num=input('请选择公共因子的个数：');  %交互式选取主因子的个数
aa=a(:,1:num)   %提出num个因子的载荷矩阵
s1=sum(aa.^2)   %计算对X的贡献率
s2=sum(aa.^2,2)  %计算共同度
