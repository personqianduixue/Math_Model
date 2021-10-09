clc, clear
ab=textread('zhu.txt');  %
y=ab(:,[2:5:10]); %提取因变量y的观测值
Y=nonzeros(y) %去掉y后面的0，并变成列向量
x123=[ab([1:13],[3:5]); ab([1:12],[8:10])]; %提取x1,x2,x3的观测值
X=[ones(25,1),x123]; %构造多元线性回归分析的数据矩阵X
[beta,betaint,r,rint,st]=regress(Y,X)  %计算回归系数和统计量等，st的第2个分量就是F统计量，下面根据统计量的表达式重新计算的结果和这里是一样的。
q=sum(r.^2)   %计算残差平方和
ybar=mean(Y)  %计算y的观测值的平均值
yhat=X*beta;   %计算y的估计值
u=sum((yhat-ybar).^2)   %计算回归平方和
m=3;    %变量的个数，拟合参数的个数为m+1
n=length(Y); %样本点的个数
F=u/m/(q/(n-m-1))   %计算F统计量的值,自由度为样本点的个数减拟合参数的个数
fw1=finv(0.025,m,n-m-1) %计算上alpha/2分位数
fw2=finv(0.975,m,n-m-1) %计算上1-alpha/2分位数
c=diag(inv(X'*X))   %计算c（j，j）的值
t=beta./sqrt(c)/sqrt(q/(n-m-1))  %计算t统计量的值
tfw=tinv(0.975,n-m-1)   %计算t分布的上alpha/2分位数
save xydata Y x123  %把Y和x123保存到mat文件xydata中，供问题（3）的二次模型使用
