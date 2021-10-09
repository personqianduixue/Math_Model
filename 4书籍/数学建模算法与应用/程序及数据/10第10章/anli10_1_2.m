clc,clear
load gj.txt   %把原始数据保存在纯文本文件gj.txt中
gj(:,[3:6])=[]; %删除数据矩阵的第3列～第6列,即使用变量1,2,7,8,9,10
gj=zscore(gj); %数据标准化
y=pdist(gj); %求对象间的欧氏距离,每行是一个对象
z=linkage(y,'average');  %按类平均法聚类
h=dendrogram(z);  %画聚类图
set(h,'Color','k','LineWidth',1.3)  %把聚类图线的颜色改成黑色，线宽加粗
for k=3:5
    fprintf('划分成%d类的结果如下：\n',k)
    T=cluster(z,'maxclust',k);  %把样本点划分成k类
    for i=1:k
      tm=find(T==i);  %求第i类的对象
      tm=reshape(tm,1,length(tm)); %变成行向量
      fprintf('第%d类的有%s\n',i,int2str(tm)); %显示分类结果
    end
    if k==5
        break
    end
    fprintf('**********************************\n');
end
