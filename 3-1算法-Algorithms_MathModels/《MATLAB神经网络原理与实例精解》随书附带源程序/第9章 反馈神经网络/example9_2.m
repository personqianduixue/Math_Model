%  example9_2.m
n=-5:.1:5;
a=satlin(n);				% 调用satlin函数
plot(n,a)                   % 画图
axis([-5,5,-1,2])			% 指定横纵坐标的范围
grid on
title('satlin函数示意图')
web -broswer http://www.ilovematlab.cn/forum-222-1.html