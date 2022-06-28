% example6_4.m

[x,t] = simplefit_dataset;		% MATLAB自带数据，x、t均为1*94向量
net = feedforwardnet;			% 创建前向网络
view(net)
net = train(net,x,t);			% 训练，确定输入输出向量的维度
view(net)
y = net(x);
perf = perform(net,y,t)			% 计算误差性能
web -broswer http://www.ilovematlab.cn/forum-222-1.html