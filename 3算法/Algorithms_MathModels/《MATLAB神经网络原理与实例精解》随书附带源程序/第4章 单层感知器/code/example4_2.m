% example4_2.m
p=[-100,100]                    % 输入数据是标量，取值范围-100~100
% p =
% 
%   -100   100

t=1                             % 网络含有一个输出节点
% t =
% 
%      1

net=newp(p,t);                  % 创建一个感知器
P=[-5,-4,-3,-2,-1,0,1,2,3,4]	% 训练输入
% P =
% 
%     -5    -4    -3    -2    -1     0     1     2     3     4

T=[0,0,0,0,0,1,1,1,1,1]         % 训练输出，负数输出0，非负数输出1
% T =
% 
%      0     0     0     0     0     1     1     1     1     1

 net=train(net,P,T);            % 用train’进行训练，会弹出框
 newP=-10:.2:10;                % 测试输入
newT=sim(net,newP);             % 测试输入的实际输出
plot(newP,newT,'LineWidth',3);
title('判断数字符号的感知器');
% web -broswer http://www.ilovematlab.cn/forum-222-1.html