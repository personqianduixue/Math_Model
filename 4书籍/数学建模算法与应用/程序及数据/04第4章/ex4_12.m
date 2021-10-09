clc, clear
x=[0     5    16    20    33    23    35    25    10];
y=[15    20    24    20    25    11     7     0     3];
xy=[x;y];
d=mandist(xy); %求xy的两两列向量间的绝对值距离
d=tril(d); %截取matlab工具箱要求的下三角矩阵
b=sparse(d) %转化为稀疏矩阵
[ST,pred]=graphminspantree(b,'Method','Kruskal')  %调用最小生成树的命令
st=full(ST); %把最小生成树的稀疏矩阵转化成普通矩阵
TreeLength=sum(sum(st))  %求最小生成树的长度
view(biograph(ST,[],'ShowArrows','off','ShowWeights','on')) %画出最小生成树
