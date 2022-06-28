%计算适应度函数

function [f,p]=objf(s);

inn=size(s,1);   %有inn个个体
bn=size(s,2);    %个体长度为bn

for i=1:inn
   x=n2to10(s(i,:));  %讲二进制转换为十进制
   xx=-1.0+x*3/(power(2,bn)-1);  %转化为[-1,2]区间的实数
   f(i)=ft(xx);  %计算函数值，即适应度
end
f=f';

%计算选择概率
fsum=sum(f.*f);
ps=f.*f/fsum;

%计算累积概率
p(1)=ps(1);
for i=2:inn
   p(i)=p(i-1)+ps(i);
end
p=p';