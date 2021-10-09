clc,clear
spec=garchset('R',2);
y=load('mydata.txt');
[Coeff,Errors,LLF,Innovations,Sigmas,Summary]=garchfit(spec,y);
Coeff
[SigmaForecast,MeanForecast]=garchpred(Coeff,y,3)
