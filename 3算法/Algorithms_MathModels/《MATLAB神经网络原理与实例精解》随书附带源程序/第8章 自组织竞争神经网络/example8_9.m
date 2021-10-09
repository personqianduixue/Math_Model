% example8_9.m
inputs = iris_dataset;			% 载入数据
net = competlayer(3);			% 创建竞争网络
net = train(net,inputs);		% 训练
outputs = net(inputs);			% 分类
classes = vec2ind(outputs)		% 格式转换。classes为分类结果，这里仅列出部分数据
c=hist(classes,3)				% 每个类别的数量
web -broswer http://www.ilovematlab.cn/forum-222-1.html