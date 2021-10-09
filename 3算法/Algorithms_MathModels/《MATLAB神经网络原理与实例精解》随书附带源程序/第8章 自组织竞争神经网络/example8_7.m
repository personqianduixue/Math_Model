% example8_7.m
rng(0)
pos=randtop(2,2)*2      % 随机拓扑结构
linkdist(pos)			% 计算节点间的距离
plot(pos(1,:),pos(2,:),'ro')
axis([-0.2,2.2,-0.2,1.2])
title('randtop linkdist')
web -broswer http://www.ilovematlab.cn/forum-222-1.html