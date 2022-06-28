for i=1:4000
    input(i,:)=10*rand(1,2)-5;
    output(i)=input(i,1)^2+input(i,2)^2;
end
output=output';

save data input output