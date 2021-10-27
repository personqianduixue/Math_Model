function y=fenmu3(t)
global k k1 kst;
sum=0;
for i=-5:1:10
      sum=sum+(newu0(i)-newu0(i-1))*newlup(t/(0.608*k*k1*kst)/i);
end
y=sum;
    %两个分布的jj运算