%高校研究生院的TOPSIS评价
%课件例题

clear 
a=[0.1 5 5000 4.7
   0.2 6 6000 5.6];
[m,n]=size(a);
qujian=[5 ,6];lb=2;ub=12;%最优区间，下界，上界
a(:,2)=intervaltransfer(qujian,lb,ub,a(:,2));
%其余向量指标规范化
for j=1:n
    b(:,j)=a(:,j)/norm(a(:,j));
end
w=[0.2,0.3,0.4,0.1];  %各个评价指标的权重
c=b.*repmat(w,m,1);%求加权矩阵
cstar=max(c);%求正理想解（针对效益型变量）
cstar(4)=min(c(:,4));%针对属性4，成本型
c0=min(c);%求负理想解
c0(4)=max(c(:,4));%属性4为成本型
for i=1:m
    sstar(i)=norm(c(i,:)-cstar);  %求到正理想解的距离
    s0(i)=norm(c(i,:)-c0);
end
f=s0./(sstar+s0);
[sf,ind]=sort(f,'descend');%求排序结果
sf

