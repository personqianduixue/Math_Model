clc, clear,format long g  %长小数的显示方式
ab0=load('you.txt');
mu=mean(ab0);sig=std(ab0); %求均值和标准差
ab=zscore(ab0); %数据标准化
a=ab(:,[1:7]);b=ab(:,[8:end]);
ncomp=2; %试着选择成分的对数
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats]=plsregress(a,b,ncomp)
n=size(a,2); m=size(b,2); %n是自变量的个数,m是因变量的个数
BETA2(1,:)=mu(n+1:end)-mu(1:n)./sig(1:n)*BETA([2:end],:).*sig(n+1:end); %原始数据回归方程的常数项
BETA2([2:n+1],:)=(1./sig(1:n))'*sig(n+1:end).*BETA([2:end],:) %计算原始变量x1,...,xn的系数，每一列是一个回归方程
format  %恢复到短小数的显示方式