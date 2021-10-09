% example5_7.m
x=-5:5;
y=3*x-7;
randn('state',2);			% 设置种子，便于重复执行
y=y+randn(1,length(y))*1.5;		% 加入噪声的直线
plot(x,y,'o');
P=x;T=y;
lr=maxlinlr(P,'bias')			% 计算最大学习率

net=linearlayer(0,lr);			% 用linearlayer创建线性层，输入延迟为0
tic;net=train(net,P,T);toc		% 用train函数训练
new_x=-5:.2:5;
new_y=sim(net,new_x);           	% 仿真
hold on;plot(new_x,new_y);
title('linearlayer用于最小二乘拟合直线');
legend('原始数据点','最小二乘拟合直线');
xlabel('x');ylabel('y');
s=sprintf('y=%f * x + %f', net.iw{1,1}, net.b{1,1})

text(-2,0,s);
web -broswer http://www.ilovematlab.cn/forum-222-1.html