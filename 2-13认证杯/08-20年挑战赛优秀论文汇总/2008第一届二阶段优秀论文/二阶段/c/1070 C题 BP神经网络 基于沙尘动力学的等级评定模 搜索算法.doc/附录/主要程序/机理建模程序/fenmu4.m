function y=fenmu4(t)
sum=0;
for i=-10:1:10
    l=(fenmu3(i)-fenmu3(i-1))*newx2(t-i);
    if (isnan(l)== 1||l<0)
        l=0;        
    end
    sum=sum+l;
end
y=sum;
    %两个分布的jj运算