% example4_3.m
net=newp([-2,2;-2,2],1);	% 创建一个感知器，有2个输入节点，1个输出节点
P=[0,0,1,1;0,1,0,1];		% 输入向量
T=[0,0,1,1];			% 期望输出
net=train(net,P,T);         	% 训练
Y=sim(net,P)                	% 仿真
% Y =
% 
%      0     0     1     1
Y=net(P)                    	% 另一种得到仿真结果的形式
% Y =
% 
%      0     0     1     1
% web -broswer http://www.ilovematlab.cn/forum-222-1.html