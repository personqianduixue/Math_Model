function y=fenmu1(t)
global k;
sum=0;
for i=-5:1:8
    l=(newqa(i)-newqa(i-1))*newsta(t/(0.608*k)/i);
    if (isnan(l)== 1||l<0)
        l=0;        
    end
    sum=sum+l;
end
y=sum;
    %两个分布的jj运算