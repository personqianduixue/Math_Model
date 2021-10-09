clc, clear
elps=randn(10000,1); x(1:2)=0;
for i=3:10000
    x(i)=-0.6*x(i-1)-0.2*x(i-2)+elps(i); %产生模拟数据
end
x=x'; m=ar(x,2);  %拟合模型
xp=predict(m,x);  %计算已知数据的预测值 
res=x-xp{1};  %计算残差向量，也可以使用命令res=resid(m,x)计算残差向量
h=lbqtest(res) %对残差向量进行Ljung-Box检验
