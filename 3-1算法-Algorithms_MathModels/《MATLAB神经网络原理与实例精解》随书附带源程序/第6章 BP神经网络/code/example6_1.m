% example6_1.m
x=-3:.2:3;
plot(x,x,'o')
hold on;
plot([0,0],x([8,24]),'^r','LineWidth',4)	% 将原始数据投射到Y轴
plot(zeros(1,length(x)),x,'o')
grid on  %网格线
title('原始数据')
y=logsig(x);								% 计算y的值
figure(2);
plot(x,y,'o')								% 显示y
hold on;
plot(zeros(1,length(y)),y,'o')
plot([0,0],y([8,24]),'^r','LineWidth',4)
grid on
title('Sigmoid函数处理之后')
% web -broswer http://www.huangchongqing.top