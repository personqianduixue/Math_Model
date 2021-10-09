clc,clear
yt=load('ranliao.txt'); %实际燃料消耗量数据以列向量的方式存放在纯文本文件中
n=length(yt); alpha=0.4; 
dyt=diff(yt); %求yt的一阶向前差分
dyt=[0;dyt]; %这里使用的是一阶向后差分，加“0”补位
dyhat(2)=dyt(2); %指数平滑值的初始值
for i=2:n
    dyhat(i+1)=alpha*dyt(i)+(1-alpha)*dyhat(i);
end
for i=1:n
    yhat(i+1)=dyhat(i+1)+yt(i);  
end
yhat
xlswrite('ranliao.xls',[yt,dyt]) 
xlswrite('ranliao.xls',[dyhat',yhat'],'Sheet1','C1')
