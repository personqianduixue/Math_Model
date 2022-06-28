%  example9_1.m
T = [-1 -1 1; 1 -1 1]'		% 吸引子为向量[-1,-1,1]和[1,-1,1]
% T =
% 
%     -1     1
%     -1    -1
%      1     1

net = newhop(T);			% 使用newhop创建联想记忆网络
Ai = T;
[Y,Pf,Af] = net(2,[],Ai)	% 使用原输入进行仿真
% Y =
%     -1     1
%     -1    -1
%      1     1
% 
% 
% Pf =
%      []
% 
% 
% Af =
%     -1     1
%     -1    -1
%      1     1

Ai = {[-0.9; -0.8; 0.7]};	% 使用不同的数据进行仿真
[Y,Pf,Af] = net({1 5},{},Ai);
Y{1}
% ans =
% 
%     -1
%     -1
%      1
web -broswer http://www.ilovematlab.cn/forum-222-1.html