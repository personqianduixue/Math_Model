% example7_2.m
tic
P=-2:.2:2;
rand('state',pi);
T=P.^2+rand(1,length(P));	% 在二次函数中加入噪声
net=newrbe(P,T,3);			% 建立严格的径向基函数网络
test=-2:.1:2;
out=sim(net,test);			% 仿真测试
toc
figure(1);
plot(P,T,'o');
hold on;
plot(test,out,'b-');
legend('输入的数据','拟合的函数');
