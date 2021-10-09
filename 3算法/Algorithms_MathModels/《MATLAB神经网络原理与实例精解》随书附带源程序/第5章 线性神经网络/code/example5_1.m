% example5_1.m
x=-5:5;
y=3*x-7;					% 直线方程为 
randn('state',2);				% 设置种子，便于重复执行
y=y+randn(1,length(y))*1.5;			% 加入噪声的直线
plot(x,y,'o');
P=x;T=y;
net=newlind(P,T);				% 用newlind建立线性层
new_x=-5:.2:5;					% 新的输入样本
new_y=sim(net,new_x);				% 仿真
hold on;plot(new_x,new_y);
legend('原始数据点','最小二乘拟合直线');
net.iw						% 权值为2.9219

% ans = 
% 
%     [2.9219]

net.b						% 偏置为-6.6797

% ans = 
% 
%     [-6.6797]

title('newlind用于最小二乘拟合直线');
web -broswer http://www.ilovematlab.cn/forum-222-1.html