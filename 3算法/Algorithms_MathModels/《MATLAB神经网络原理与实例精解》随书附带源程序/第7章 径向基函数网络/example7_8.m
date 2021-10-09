% example7_8.m

rng(2);
a=rand(8,2)*10;			% 输入训练样本，8个二维向量
p=ceil(a)

tc=[2,1,1,1,2,1,2,1];		% 期望输出
plot(p([1,5,7],1),p([1,5,7],2),'o');
hold on;
plot(p([2,3,4,6,8],1),p([2,3,4,6,8],2),'+');
legend('第一类','第二类');
axis([0,8,1,9])
hold off
t=ind2vec(tc);
net=newpnn(p',t);		% 设计PNN网络
y=sim(net,p');			% 仿真
yc=vec2ind(y)			% 实际输出等于期望输出

web -broswer http://www.ilovematlab.cn/forum-222-1.html