function y=fenzi2(t)

sum=0;
for i=-5:1:8
    l=(newsta(i)-newsta(i-1))*fenzi1(t/3.912/i);
    if (isnan(l)== 1||l<0)
        l=0;        
    end
    sum=sum+l;
end
y=sum;
    %两个分布的jj运算