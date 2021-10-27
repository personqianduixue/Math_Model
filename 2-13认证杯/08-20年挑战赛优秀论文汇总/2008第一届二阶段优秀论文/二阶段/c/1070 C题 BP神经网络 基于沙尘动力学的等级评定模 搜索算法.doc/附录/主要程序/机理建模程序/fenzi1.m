function y=fenzi1(t)
sum=0;
for i=0:1:10
    sum=sum+(newva2(i)-newva2(i-1))*newx1(t-i);
end
y=sum;
    %两个分布的和运算