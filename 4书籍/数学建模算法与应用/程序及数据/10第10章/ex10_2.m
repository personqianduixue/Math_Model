clc,clear
a=textread('ch.txt');    
d=1-abs(a); %进行数据变换,把相关系数转化为距离
d=tril(d);  %提出d矩阵的下三角部分
b=nonzeros(d);%去掉d中的零元素
b=b';  %化成行向量
z=linkage(b,'complete'); %按最长距离法聚类  
y=cluster(z,'maxclust',2)   %把变量划分成两类
ind1=find(y==1);ind1=ind1'  %显示第一类对应的变量标号
ind2=find(y==2);ind2=ind2'  %显示第二类对应的变量标号
h=dendrogram(z); %画聚类图
set(h,'Color','k','LineWidth',1.3)  %把聚类图线的颜色改成黑色，线宽加粗
