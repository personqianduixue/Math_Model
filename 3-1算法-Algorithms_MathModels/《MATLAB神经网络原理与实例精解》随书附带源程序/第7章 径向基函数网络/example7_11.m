% example7_11.m

P = [1 2 3];				% 训练输入向量
T = [2.0 4.1 5.9]			% 训练输入的期望输出值
net = newgrnn(P,T);			% 设计GRNN网络
x=[1.5,2.5];				% 测试输出。计算x=1.5和x=2.5的查找
y=sim(net,x)				% 测试结果

web -broswer http://www.ilovematlab.cn/forum-222-1.html