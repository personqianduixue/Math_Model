% example7_12.m

x=[3,0;2,7;4,4]		% 输入向量
w=[0.7,0.2,0.1]		% 权值
z=normprod(w,x)		% 计算归一化点积
w*x./sum(x)		% 验证其算法
web -broswer http://www.ilovematlab.cn/forum-222-1.html