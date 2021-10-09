% example8_8.m
P = [.2 .8  .1 .9; .3 .5 .4 .5];		% 待分类坐标点
plot(P(1,:),P(2,:),'o');				% 绘制坐标点
axis([0,1,0,1])
set(gcf,'color','w')
grid on
title('四个坐标点的分类')
net = newc(P,2);						% 创建竞争层
 net = train(net,P);
Y = net(P)


Yc = vec2ind(Y)
P

c1=P(:,Yc==1);                          % 绘制分类结果
c2=P(:,Yc==2);
plot(c1(1,:),c1(2,:),'ro','LineWidth',2)
hold on
plot(c2(1,:),c2(2,:),'k^','LineWidth',2)
title('四个坐标点的分类结果')
axis([0,1,0,1])
web -broswer http://www.ilovematlab.cn/forum-222-1.html