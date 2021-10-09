% example9_4.m
T = [-1 -1 1; 1 -1 1]'				% 吸引子向量
% T =
% 
%     -1     1
%     -1    -1
%      1     1

net = newhop(T);					% 用newho设计网络
Ai = T;
[Y,Pf,Af] = net(2,[],Ai)				% 仿真
% Y =
% 
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

net2=nnt2hop(net.LW{1},net.b{1});	% 将newho创建的网络权值和阈值赋给net2
[Y,Pf,Af] = net(2,[],Ai)				% net2的仿真结果与net相同
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
web -broswer http://www.ilovematlab.cn/forum-222-1.html