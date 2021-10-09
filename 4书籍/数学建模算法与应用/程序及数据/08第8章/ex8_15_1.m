clc,clear
a=textread('hua.txt');  %把原始数据按照原来的排列格式存放在纯文本文件hua.txt
a=nonzeros(a')'; %按照原来数据的顺序去掉零元素
r11=autocorr(a)   %计算自相关函数
r12=parcorr(a)   %计算偏相关函数
da=diff(a);      %计算1阶差分
r21=autocorr(da)  %计算自相关函数
r22=parcorr(da)   %计算偏相关函数
n=length(da);  %计算差分后的数据个数
for i=0:3
    for j=0:3
    spec= garchset('R',i,'M',j,'Display','off'); %指定模型的结构
    [coeffX,errorsX,LLFX] = garchfit(spec,da);  %拟合参数
    num=garchcount(coeffX);   %计算拟合参数的个数
    %compute Akaike and Bayesian Information Criteria
    [aic,bic]=aicbic(LLFX,num,n); 
    fprintf('R=%d,M=%d,AIC=%f,BIC=%f\n',i,j,aic,bic);  %显示计算结果
    end
end
r=input('输入阶数R＝');m=input('输入阶数M＝');
spec2= garchset('R',r,'M',m,'Display','off'); %指定模型的结构
[coeffX,errorsX,LLFX] = garchfit(spec2,da)    %拟合参数
[sigmaForecast,w_Forecast] = garchpred(coeffX,da,10)  %计算10步预报值
x_pred=a(end)+cumsum(w_Forecast)   %计算原始数据的10步预测值
