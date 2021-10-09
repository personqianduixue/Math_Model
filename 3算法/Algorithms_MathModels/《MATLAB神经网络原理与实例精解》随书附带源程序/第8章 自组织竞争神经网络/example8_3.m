% example8_3.m
pos = randtop(8,5);
rng(2)
net = selforgmap([8 5],'topologyFcn','randtop');
plotsomtop(net)
web -broswer http://www.ilovematlab.cn/forum-222-1.html