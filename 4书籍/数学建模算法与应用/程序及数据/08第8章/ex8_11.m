clc,clear
randn('state',sum(clock));  %初始化随机数发生器
elps=randn(1,10000);   %产生10000个服从标准正态分布的随机数
x(1)=0;   %赋初始值
for j=2:10000
    x(j)=0.8*x(j-1)+elps(j)-0.4*elps(j-1); %产生样本点
end
x=x'; %转换成下面需要的列向量
for i=0:3
    for j=1:3
        if i==0 & j==0
            continue  %arma(p,q)模型中，p,q不能同时为0
        end
    m=armax(x,[i,j]);  %拟合模型，已知数据必须是列向量
    myaic=aic(m); %计算AIC指标
    fprintf('p=%d,q=%d,AIC=%f\n',i,j,myaic);  %显示计算结果
    end
end
p=input('输入阶数p＝');q=input('输入阶数q＝'); %输入模型的阶数
m=armax(x,[p,q])  %拟合指定参数p,q的模型
res=resid(m,x); %计算残差向量
h=lbqtest(res) %进行chi2检验
