function lengthstat()
[count,mat]=lengthplot(850,1370,1500);
for i=1:1000
    [count,temp] =lengthplot(850,1370,1500);
    mat=mat+temp;
end
mat = mat/1000;
i=1:850;
plot(i,mat)
end