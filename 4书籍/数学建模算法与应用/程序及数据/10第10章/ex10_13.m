clc,clear
r=[1 -1/3 2/3;-1/3 1 0;2/3 0 1];
%下面利用相关系数矩阵求主成分解，vec1的列为r的特征向量，即主成分的系数
[vec1,val,rate]=pcacov(r) %val为r的特征值，rate为各个主成分的贡献率
f1=repmat(sign(sum(vec1)),size(vec1,1),1); %构造与vec1同维数的元素为±1的矩阵
vec2=vec1.*f1; %修改特征向量的正负号，每个特征向量乘以所有分量和的符号函数值
f2=repmat(sqrt(val)',size(vec2,1),1);
lambda=vec2.*f2    %构造全部因子的载荷矩阵，见（10.27）式 
num=2;  %选择两个主因子
[lambda2,t]=rotatefactors(lambda(:,1:num),'method', 'varimax')  %对载荷矩阵进行旋转
%其中lambda2为旋转载荷矩阵，t为变换的正交矩阵
