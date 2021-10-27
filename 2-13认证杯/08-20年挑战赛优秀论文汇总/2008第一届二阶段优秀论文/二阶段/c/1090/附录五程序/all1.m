%将所有数据按站分类，并拟合及计算误差
data1=data(:,1:2);  %直接从excel 中插入数据data，为3列的矩阵，分别是站号，气象因子，和沙尘暴平均频率
b1=data(:,1);
b2=data(:,3);
data2=[b1 b2];
qv=ave(data1);      %将气象因子分站统计
dv=ave(data2);      %将沙尘暴频率分站统计
dn=val(p,qv);       %p是两列的矩阵，上式中拟合的线性方程系数
e=abs((dn-dv)./dv); %误差计算
[s1 s2]=size(e);
s=1:s2;
plot(s,e,'ro'),title('误差图'),ylabel('误差数值');
dv=dv';
dn=dn';
e=e';