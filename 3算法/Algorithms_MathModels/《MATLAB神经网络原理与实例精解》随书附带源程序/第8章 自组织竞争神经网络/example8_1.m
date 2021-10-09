% example8_1.m

pos = gridtop(8,5);		% 创建网格
pos                     % 神经元的坐标

net = selforgmap([8 5],'topologyFcn','gridtop');
plotsomtop(net)			% 显示网络
web -broswer http://www.ilovematlab.cn/forum-222-1.html