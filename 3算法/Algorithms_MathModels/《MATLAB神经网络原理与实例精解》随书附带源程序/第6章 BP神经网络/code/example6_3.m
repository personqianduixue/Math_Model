% example6_3.m
% newff
x=-4:.5:4;
y=x.^2-x;
net=newff(minmax(x),minmax(y),10);					% net为新版newff创建的
net=train(net,x,y);									% 训练
xx=-4:.2:4;
yy=net(xx);
plot(x,y,'o-',xx,yy,'*-')
title('新版newff')
net1=newff(minmax(x),[10,1],{'tansig','purelin'},'trainlm');	% net1为旧版newff创建的
net1=train(net1,x,y);								% 训练
yy2=net1(xx);
figure(2);
plot(x,y,'o-',xx,yy2,'*-')
title('旧版newff')
% web -broswer http://www.ilovematlab.cn/forum-222-1.html