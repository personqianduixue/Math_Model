% example5_2.m
x=-5:5;
y=3*x-7;                        % 直线方程为 
randn('state',2);		% 设置种子，便于重复执行
y=y+randn(1,length(y))*1.5;	% 加入噪声的直线
plot(x,y,'o');
P=x;T=y;
net=newlin(minmax(P),1,[0],maxlinlr(P));	% 用newlin创建线性网络
tic;net=train(net,P,T);toc	% 训练。与newlind不同，newlin创建的网络需要调用训练函数
new_x=-5:.2:5;
new_y=sim(net,new_x);           % 仿真
hold on;plot(new_x,new_y);
legend('原始数据点','最小二乘拟合直线');
title('newlin用于最小二乘拟合直线');
net.iw

% ans = 
% 
%     [2.9219]

net.b

% ans = 
% 
%     [-6.6797]
web -broswer http://www.ilovematlab.cn/forum-222-1.html