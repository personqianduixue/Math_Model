clc,clear
x=load('water.txt');  %把原始数据按照表中的格式存放在纯文本文件water.txt
x=x'; x=x(:);  %按照时间的先后次序，把数据变成列向量
s=12;  %周期s=12
n=12;  %预报数据的个数
m1=length(x);   %原始数据的个数
for i=s+1:m1
    y(i-s)=x(i)-x(i-s); %进行周期差分变换
end
w=diff(y);   %消除趋势性的差分运算
m2=length(w); %计算最终差分后数据的个数
for i=0:3
    for j=0:s+1
    spec= garchset('R',i,'M',j,'Display','off'); %指定模型的结构
    [coeffX,errorsX,LLFX] = garchfit(spec,w);  %拟合参数
    num=garchcount(coeffX);   %计算拟合参数的个数
    [aic,bic]=aicbic(LLFX,num,m2); %计算Akaike和Bayesian信息准则 
    fprintf('R=%d,M=%d,AIC=%f,BIC=%f\n',i,j,aic,bic);  %显示计算结果
    end
end
r=input('输入阶数p＝');m=input('输入阶数q＝');
spec2= garchset('R',r,'M',m,'Display','off'); %指定模型的结构
[coeffX,errorsX,LLFX] = garchfit(spec2,w)  %拟合参数
[sigmaForecast,w_Forecast] = garchpred(coeffX,w,n)  %求w的预报值
yhat=y(end)+cumsum(w_Forecast)     %求y的预报值
for j=1:n
    x(m1+j)=yhat(j)+x(m1+j-s); %求x的预测值
end
xhat=x(m1+1:end)   %截取n个预报值
