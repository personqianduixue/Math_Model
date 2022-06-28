% example4_7.m  创建一个感知器，计算仿真时的误差性能
net = newp([-10 10],1);		% 创建一个感知器，该感知器拥有一个输入节点和一个输出节点
p = [-10 -5 0 5 10];		% 训练输入向量
t = [0 0 1 1 1];		% 期望输出
y = sim(net,p)              	% 直接仿真

% y =
% 
%  1     1     1     1     1

e = t-y                     	% 误差

% e =
% 
%  -1    -1     0     0     0

perf = mae(e)               	% 平均绝对差

% perf =
% 
%  0.4000

sum(abs(e))/length(e)		% 取绝对值，再求平均，与mae函数计算结果相同

% ans =
% 
%  0.4000

net=train(net,p,t);		% 进行训练后在计算平均绝对差
y = sim(net,p);
e = t-y

% e =
% 
%  0     0     0     0     0

perf = mae(e)               	% 平均绝对差为0

% perf =
% 
%  0
% web -broswer http://www.ilovematlab.cn/forum-222-1.html