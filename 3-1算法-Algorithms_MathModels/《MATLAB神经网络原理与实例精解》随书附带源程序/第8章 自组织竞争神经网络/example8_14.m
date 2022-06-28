% example8_14.m

x=[1,2,3;1,2,4]					% 待归一化数据
[xx,settings]=mapminmax(x);		% 归一化到[0,1]
xx
[settings.xmin,settings.xmax]		% 结构体settings中保存了每行的最大最小值
fp.ymin=0;fp.ymax=10	
[xx,settings]=mapminmax(x,fp);		% 映射到[0,10]区间
xx
[xx,settings]=mapminmax(x',fp);		% 按列进行归一化
xx
web -broswer http://www.ilovematlab.cn/forum-222-1.html