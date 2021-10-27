function y=fenmu2(t)
global k1 kst k;
sum=0;
for i=-5:1:10
    l=(newu0(i)-newu0(i-1))*newldown(t/(0.608*k1*kst*k)/i);
    if (isnan(l)== 1||l<0)
        l=0;        
    end
    sum=sum+l;
end
y=sum;
    %两个分布的jj运算