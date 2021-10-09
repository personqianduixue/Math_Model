clc,clear
y=[533.8  574.6  606.9  649.8   705.1  772.0  816.4  892.7  963.9  1015.1  1102.7];
m=length(y);   
n=[4,5];   %n为移动平均的项数
for i=1:length(n)    %由于n的取值不同，下面使用了细胞数组
    for j=1:m-n(i)+1
        yhat{i}(j)=sum(y(j:j+n(i)-1))/n(i); 
    end
    y12(i)=yhat{i}(end);  %提出第12月份的预测值
    s(i)=sqrt(mean((y(n(i)+1:end)-yhat{i}(1:end-1)).^2)); %求预测的标准误差
end
y12, s   %分别显示两种方法的预测值和预测的标准误差
