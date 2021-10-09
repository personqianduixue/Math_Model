clc, clear
elps=randn(10000,1); x(1:2)=0;
for i=3:10000
    x(i)=-0.6*x(i-1)-0.2*x(i-2)+elps(i); %产生模拟数据
end
xlswrite('data1.xls',x(end-9:end)) %把x的后10个数据保存到Excel文件中
dlmwrite('mydata.txt',x)  %供下面例8.13的GARCH模型使用同样的数据
x=x'; m=ar(x,2)   %进行参数估计
xp1=predict(m,[x;0],1);  %1步预测，样本数据必须为列向量,要预测1个值，x后要加1个任意数，1步预测数据使用到t-1步的数据
x10001=xp1{1}(end)  %预测第10001个值,为xp1的最后一个值
xp2=predict(m,[x;x10001;0],1); %已知数据后要加1个任意数
x10002=xp2{1}(end)  %预测第10002个值，为xp2的最后一个值
xp3=predict(m,[x;x10001;x10002;0],1); %已知数据后要加1个任意数
x10003=xp3{1}(end)  %预测第10003个值，为xp3的最后一个值
