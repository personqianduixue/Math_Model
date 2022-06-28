% example8_13.m
[x,t] = iris_dataset;		% 加载数据，x为输入样本，t为期望输出
rng(0)
whos

ri=randperm(150);           % 划分训练与测试集
x1=x(:,ri(1:50));
t1=t(:,ri(1:50));
x2=x(:,ri(51:150));
t2=t(:,ri(51:150));
net = lvqnet(20);			% 创建网络进行训练
net = train(net,x1,t1);
y = net(x2);				% 测试
yy=vec2ind(y);
ty=vec2ind(t2);
sum(yy==ty)/length(yy)

web -broswer http://www.ilovematlab.cn/forum-222-1.html