clc, clear
a=[0.83	 0.90	0.99	  0.92	0.87	  0.95
326	 295	 340  287	310	  303
21	 38	     25	  19	 27	  10
3.2	2.4	     2.2   2.0	 0.9   1.7
0.20	0.25	    0.12   0.33 	0.20	  0.09
0.15	0.20	    0.14   0.09	0.15   0.17
250	180	    300	   200	150   175
0.23	0.15	    0.27   0.30	0.18   0.26
0.87	0.95	    0.99	   0.89	0.82	  0.94];
for i=[1 5:9]    %效益型指标标准化
    a(i,:)=(a(i,:)-min(a(i,:)))/(max(a(i,:))-min(a(i,:)));
end
for i=2:4  %成本型指标标准化
   a(i,:)=(max(a(i,:))-a(i,:))/(max(a(i,:))-min(a(i,:))); 
end
[m,n]=size(a);
cankao=max(a')'  %求参考序列的取值
t=repmat(cankao,[1,n])-a;  %求参考序列与每一个序列的差
mmin=min(min(t));   %计算最小差
mmax=max(max(t));  %计算最大差
rho=0.5; %分辨系数
xishu=(mmin+rho*mmax)./(t+rho*mmax)  %计算灰色关联系数
guanliandu=mean(xishu)   %取等权重，计算关联度
[gsort,ind]=sort(guanliandu,'descend')  %对关联度按照从大到小排序
