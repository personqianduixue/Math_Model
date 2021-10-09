clc,clear
a=[1,0;1,1;3,2;4,3;2,5];
y=pdist(a,'cityblock');  %求a的两两行向量间的绝对值距离
yc=squareform(y)  %变换成距离方阵
z=linkage(y)  %产生等级聚类树
[h,t]=dendrogram(z) %画聚类图
T=cluster(z,'maxclust',3)  %把对象划分成3类
for i=1:3
    tm=find(T==i);  %求第i类的对象
    tm=reshape(tm,1,length(tm)); %变成行向量
    fprintf('第%d类的有%s\n',i,int2str(tm)); %显示分类结果
end
