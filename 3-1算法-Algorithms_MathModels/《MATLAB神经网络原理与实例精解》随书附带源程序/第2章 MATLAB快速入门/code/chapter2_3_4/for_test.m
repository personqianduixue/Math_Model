% for_test.m
for i=1:5
   x=0;
    for j=1:i
       x=x+j; 
    end
    fprintf('从1到%d的整数和为 ',i);
    disp(x)
end