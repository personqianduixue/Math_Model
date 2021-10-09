% example4_1.m
p=[-1,1;-1,1]		% 输入向量有两个分量，两个分量取值范围均为-1~1
% p =
% 
%     -1     1
%     -1     1

t=1;			% 共有1个输出节点
net=newp(p,t);		% 创建感知器
P=[0,0,1,1;0,1,0,1]	% 用于训练的输入数据，每列是一个输入向量
% P =
% 
%      0     0     1     1
%      0     1     0     1

T=[0,1,1,1]		% 输入数据的期望输出
% T =
% 
%      0     1     1     1

net=train(net,P,T);	% train函数用于训练
newP=[0,0.9]';		% 第一个测试数据
newT=sim(net,newP)	% 第一个测试数据的输出为0
% newT =
% 
%      0

newP=[0.9,0.9]';		% 第二个测试数据
newT=sim(net,newP)	% 第二个测试数据的输出为1
% newT =
% 
%      1

newT=sim(net,P)		% 用原训练数据做测试，实际输出等于期望输出
% newT =
% 
%      0     1     1     1
% web -broswer http://www.ilovematlab.cn/forum-222-1.html