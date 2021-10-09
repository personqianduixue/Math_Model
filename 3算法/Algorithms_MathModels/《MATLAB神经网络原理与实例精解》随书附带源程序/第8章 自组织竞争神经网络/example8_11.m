% example8_11.m
x = simplecluster_dataset;
plot(x(1,:),x(2,:),'o')
set(gcf,'color','w')
title('原始数据')


net = selforgmap([8 8]);		% 创建自组织映射网络
net = train(net,x);				% 训练
y = net(x);
classes = vec2ind(y);
hist(classes,64)				% 显示聚类结果
set(gcf,'color','w')
title('聚类结果')
xlabel('类别')
ylabel('类别包含的样本数量')

net = selforgmap([2,3]);
net = train(net,x);
y = net(x);
classes = vec2ind(y);
c=hist(classes,6)			% 6个类别包含的样本个数
plotsomhits(net,x)          % 显示每个类别的个数
plotsompos(net,x)           % 显示类别中心点的位置


web -broswer http://www.ilovematlab.cn/forum-222-1.html