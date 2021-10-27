function y=ttdiv(t)
sum=0;
for i=-2:1:10
     l=(fenmu6(i)-fenmu6(i-1))*fenzi2(t*i);
     if(sum>0.01&&l<0) break;
     end
     if (isnan(l)== 1||l<0)
        l=0;        
     end
    sum=sum+l
end
y=sum;
    %两个分布的除法运算