clc,clear
ab0=load('pz.txt');   %原始数据存放在纯文本文件pz.txt中
mu=mean(ab0);sig=std(ab0); %求均值和标准差
rr=corrcoef(ab0);   %求相关系数矩阵
ab=zscore(ab0); %数据标准化
a=ab(:,[1:3]);b=ab(:,[4:end]);  %提出标准化后的自变量和因变量数据
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats] =plsregress(a,b)
xw=a\XS  %求自变量提出成分系数，每列对应一个成分，这里xw等于stats.W
yw=b\YS  %求因变量提出成分的系数
ncomp=input('请根据PCTVAR的值确定提出成分对的个数ncomp=');
[XL2,YL2,XS2,YS2,BETA2,PCTVAR2,MSE2,stats2] =plsregress(a,b,ncomp)
n=size(a,2); m=size(b,2);%n是自变量的个数,m是因变量的个数
beta3(1,:)=mu(n+1:end)-mu(1:n)./sig(1:n)*BETA2([2:end],:).*sig(n+1:end); %原始数据回归方程的常数项
beta3([2:n+1],:)=(1./sig(1:n))'*sig(n+1:end).*BETA2([2:end],:) %计算原始变量x1,...,xn的系数，每一列是一个回归方程
bar(BETA2','k')   %画直方图
yhat=repmat(beta3(1,:),[size(a,1),1])+ab0(:,[1:n])*beta3([2:end],:)  %求y1,..,ym的预测值
ymax=max([yhat;ab0(:,[n+1:end])]); %求预测值和观测值的最大值
%下面画y1,y2,y3的预测图，并画直线y=x
figure, subplot(2,2,1)
plot(yhat(:,1),ab0(:,n+1),'*',[0:ymax(1)],[0:ymax(1)],'Color','k')
legend('单杠成绩预测图',2)
subplot(2,2,2)
plot(yhat(:,2),ab0(:,n+2),'O',[0:ymax(2)],[0:ymax(2)],'Color','k')
legend('弯曲成绩预测图',2)
subplot(2,2,3)
plot(yhat(:,3),ab0(:,end),'H',[0:ymax(3)],[0:ymax(3)],'Color','k')
legend('跳高成绩预测图',2)
