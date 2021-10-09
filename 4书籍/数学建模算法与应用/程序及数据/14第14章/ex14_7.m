clc, clear
aw=load('zhb.txt'); %把x1,...,x6的数据和权重数据保存在纯文本文件zhb.txt中
w=aw(end,:); %提取权重向量
a=aw([1:end-1],:); %提取指标数据
a(:,[2,6])=-a(:,[2,6]); %把成本型指标转换成效益型指标
ra=tiedrank(a) %对每个指标值分别编秩，即对a的每一列分别编秩
[n,m]=size(ra); %计算矩阵sa的维数
RSR=mean(ra,2)/n  %计算秩和比
W=repmat(w,[n,1]);
WRSR=m*mean(ra.*W,2)/n  %计算加权秩和比
p=[1:n]/n;    %计算累积频率
p(end)=1-1/(4*n) %修正最后一个累积频率，最后一个累积频率按1-1/(4*n)估计
Probit=norminv(p,0,1)+5  %计算标准正态分布的p分位数+5
X=[ones(n,1),Probit'];  %构造一元线性回归分析的数据矩阵
[ab,abint,r,rint,stats]=regress(WRSR,X)  %一元线性回归分析
WRSRfit=ab(1)+ab(2)*Probit  %计算WRNR的估计值
[sWRSRfit,ind]=sort(WRSRfit,'descend')  %对WRNR的估计值按照从大到小排序
