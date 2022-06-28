% example7_10.m

ind=[1 3 2 3]			% 下标形式
vec=ind2vec(ind)		% 下标形式转为向量形式
b=full(vec)			% 稀疏矩阵转换为普通矩阵
vec2ind(b)			% 向量形式转换为下标形式

web -broswer http://www.ilovematlab.cn/forum-222-1.html