function y=fenmu6(t)
global k;
sum=0;
for i=-5:1:10
    l=(fenmu4(i)-fenmu4(i-1))*fenmu5(t/(k*9.8*1.5)/i);
    if (isnan(l)== 1||l<0)
        l=0;        
    end
    sum=sum+l;
    
end
y=sum;
    %两个分布的jj运算