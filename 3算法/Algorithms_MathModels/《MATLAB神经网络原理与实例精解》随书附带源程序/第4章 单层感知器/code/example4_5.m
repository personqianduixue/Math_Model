% example4_5.m
net=newp([0,1;-2,2],1);		% 创建感知器
net.iw{1,1}			% 创建时的权值

% ans =
% 
%  0     0

net.b{1}			% 创建时的偏置

% ans =
% 
%  0

P=[0,1,0,1;0,0,1,1]		% 训练输入向量

% P =
% 
%  0     1     0     1
%  0     0     1     1

T=[0,0,0,1]			% 训练输入向量的期望输出

% T =
% 
%    0     0     0     1

net=train(net,P,T);		% 训练
net.iw{1,1}				% 训练后的权值
% ans =
% 
%  1     2

net.b{1}				% 训练后的偏置
% ans =
% 
% -3

net=init(net);			% 初始化
net.iw{1,1}				% 初始化后的权值
% ans =
% 
%  0     0

net.b{1}				% 初始化后的偏置
% ans =
% 
%  0
net.initFcn				% net.initFcn值
% ans =
% 
% initlay
net.initParam			% 当net.initFcn= initlay时，net.initParam自动为空
% SWITCH expression must be a scalar or string constant.
% 
% Error in network/subsref (line 140)
%         switch (subs)
% web -broswer http://www.ilovematlab.cn/forum-222-1.html