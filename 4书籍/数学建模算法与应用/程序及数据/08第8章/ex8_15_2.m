clc,clear
a=textread('hua.txt');  %把原始数据按照原来的排列格式存放在纯文本文件hua.txt
a=nonzeros(a')'; %按照原来数据的顺序去掉零元素
da=diff(a);      %计算1阶差分
spec3= garchset('R',0,'M',1,'Display','off'); %指定模型的结构
[coeffX,errorsX,LLFX] = garchfit(spec3,da)    %拟合参数,da必须列向量
[sigmaForecast,w_Forecast] = garchpred(coeffX,da,10)  %计算10步预报值
x_pred=a(end)+cumsum(w_Forecast)   %计算原始数据的10步预测值
