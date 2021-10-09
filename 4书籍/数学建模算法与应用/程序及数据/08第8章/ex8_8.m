clc, clear
elps=randn(10000,1); x(1:2)=0;
for i=3:10000
    x(i)=-0.6*x(i-1)-0.2*x(i-2)+elps(i); %产生模拟数据
end
for i=1:3
    m{i}=ar(x,i);   %拟合模型
    myaic(i)=aic(m{i}); %计算AIC的值
end
myaic
