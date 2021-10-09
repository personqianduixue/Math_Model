clc,clear
a=[1,0;1,1;3,2;4,3;2,5];
[m,n]=size(a);
d=zeros(m);
d=mandist(a'); %mandist求矩阵行向量组之间的两两绝对值距离
d=tril(d); %截取下三角元素
nd=nonzeros(d);   %去掉d中的零元素，非零元素按列排列
nd=union(nd,nd)   %去掉重复的非零元素
for i=1:m-1
    nd_min=min(nd);
    [row,col]=find(d==nd_min);tm=union(row,col);  %row和col归为一类
    tm=reshape(tm,1,length(tm));  %把数组tm变成行向量  
    fprintf('第%d次合成，平台高度为%d时的分类结果为：%s\n',...
        i,nd_min,int2str(tm));
    nd(find(nd==nd_min))=[]; %删除已经归类的元素
    if length(nd)==0
        break
    end
end
