clc, clear
elps=randn(10000,1);
for i=3:10000
    x(i)=elps(i)-0.6*elps(i-1)-0.2*elps(i-2); %产生模拟数据
end
x=x'; m=armax(x,[0,2])  %拟合ARMA(0,2)模型，x必须为列向量
