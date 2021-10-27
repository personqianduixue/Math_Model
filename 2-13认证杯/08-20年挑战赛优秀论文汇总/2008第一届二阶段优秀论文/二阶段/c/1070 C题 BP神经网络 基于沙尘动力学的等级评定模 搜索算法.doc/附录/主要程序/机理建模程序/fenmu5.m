function y=fenmu5(t)
sum=0;
for i=-5:1:10
    l=(fenmu1(i)-fenmu1(i-1))*fenmu2(t+i);
    if (isnan(l)== 1||l<0)
        l=0;        
    end
    sum=sum+l;
end
y=sum;
    %两个分布的jj运算