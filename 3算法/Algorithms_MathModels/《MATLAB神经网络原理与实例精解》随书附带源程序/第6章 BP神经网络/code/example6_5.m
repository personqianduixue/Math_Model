% example6_5.m
rng('default')
rng(2)
P = [0 1 2 3 4 5 6 7 8 9 10];	% 网络输入
T = [0 1 2 3 4 3 2 1 2 3 4];	% 期望输出
ff=newff(P,T,20);				% 建立一个BP网络，包含一个20个节点的隐含层
ff.trainParam.epochs = 50;
ff = train(ff,P,T);				% 训练
Y1 = sim(ff,P);					% 仿真
cf=newcf(P,T,20);		        % 用newcf建立前向网络
cf.trainParam.epochs = 50;
cf = train(cf,P,T);			    % 训练
Y2 = sim(cf,P);					% 仿真
plot(P,T,'o-');					% 绘图
hold on;
plot(P,Y1,'^m-');
plot(P,Y2,'*-k');
title('newff & newcf')
legend('原始数据','newff结果','newcf结果',0)
% web -broswer http://www.ilovematlab.cn/forum-222-1.html