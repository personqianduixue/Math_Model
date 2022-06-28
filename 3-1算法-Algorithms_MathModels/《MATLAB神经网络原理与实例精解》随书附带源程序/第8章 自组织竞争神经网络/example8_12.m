% example8_12.m

P = [-3 -2 -2  0  0  0  0 +2 +2 +3; ...		% 输入样本是10个二维向量
0 +1 -1 +2 +1 -1 -2 +1 -1  0];
Tc = [1 1 1 2 2 2 2 1 1 1];					% 目标类别
T = ind2vec(Tc);
net = newlvq(P,4,[.6 .4]);					% 创建LVQ网络
view(net)
net = train(net,P,T);						% 训练
Y = net(P)                                  % 测试
Yc = vec2ind(Y)
Tc

web -broswer http://www.ilovematlab.cn/forum-222-1.html