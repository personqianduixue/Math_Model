% example8_2.m

pos = hextop(3,4,2);                        % 建立3*4的两层六边形
pos

plot3(pos(1,:),pos(2,:),pos(3,:),'o')		% 显示节点位置
title('hex拓扑')
set(gcf,'color','w')
web -broswer http://www.ilovematlab.cn/forum-222-1.html