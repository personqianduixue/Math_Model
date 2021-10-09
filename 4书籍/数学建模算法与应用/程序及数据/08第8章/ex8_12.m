clc,clear
spec=garchset('C',0,'AR',0.8,'MA',0.4,'K',0.01,'GARCH',0.2,'ARCH',0.3) %指定模型的结构
y=garchsim(spec,10000); %产生指定结构模型的10000个模拟数据
[Coeff,Errors,LLF,Innovations,Sigmas,Summary]=garchfit(spec,y)  %模型拟合
h=lbqtest(Innovations)  %进行chi2检验
[SigmaForecast,MeanForecast]=garchpred(Coeff,y,3)  %预测未来的3个值
