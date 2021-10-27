%将各省余下的待预测数据放入网络模型进行仿真 
pn = mapminmax('apply',data,ps); % 预处理
an = sim(net1,pn); % 仿真
a = mapminmax('reverse',an,ts); %返回结果
e=abs(a-t);%计算误差
error=e./t;
plot(a,'go')        %将结果作图
hold
plot(t,'r*')
figure
plot(error,'b.')