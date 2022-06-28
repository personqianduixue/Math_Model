% example7_9.m
n = [0; 1; -0.5; 0.5]		% 网络输入向量

a = compet(n);              	% 求网络输出
subplot(2,1,1), bar(n), ylabel('n')
subplot(2,1,2), bar(a), ylabel('a')
web -broswer http://www.ilovematlab.cn/forum-222-1.html