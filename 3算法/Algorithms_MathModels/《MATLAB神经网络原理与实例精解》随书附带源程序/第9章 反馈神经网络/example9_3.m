%  example9_3.m
n=-5:.1:5;
a=satlins(n);			% 调用satlins函数
plot(n,a)				% 绘图
axis([-5,5,-2,2])
grid on
title('satlins函数曲线')
web -broswer http://www.ilovematlab.cn/forum-222-1.html