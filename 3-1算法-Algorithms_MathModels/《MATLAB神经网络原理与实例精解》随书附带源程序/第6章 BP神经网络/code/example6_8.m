% example6_8.m
x=-4:.1:4;
y=logsig(x);			% logsig函数
dy=dlogsig(x,y);        % logsig函数的导数
subplot(211)
plot(x,y);
title('logsig')
subplot(212);
plot(x,dy);
title('dlogsig')
web -broswer http://www.ilovematlab.cn/forum-222-1.html