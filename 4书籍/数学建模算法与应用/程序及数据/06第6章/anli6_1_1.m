clc, clear
a=textread('data4.txt'); %把原始数据保存在纯文本文件data4.txt中
x=a([2:2:6],:)';   %提出人口数据
x=nonzeros(x);  %去掉后面的零，并变成列向量
t=[1790:10:2000]';
t0=t(1); x0=x(1);
fun=@(cs,td)cs(1)./(1+(cs(1)/x0-1)*exp(-cs(2)*(td-t0))); %cs(1)=xm,cs(2)=r
cs=lsqcurvefit(fun,rand(2,1),t(2:end),x(2:end),zeros(2,1))
xhat=fun(cs,[t;2010])  %预测已知年代和2010年的人口
