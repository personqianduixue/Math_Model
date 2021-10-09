function f22=f22(x)
Bound=[0 10];

if nargin==0
    f22 = Bound;
else
aij=[4 4 4 4;
     1 1 1 1;
     8 8 8 8;
     6 6 6 6;
     3 7 3 7;
     2 9 2 9;
     5 5 3 3];
ci=[.1 .2 .2 .4 .4 .6 .3];

 
f22=0;

for i=1:7
    f22=f22+(norm(x-aij(i,:)').^2+ci(:,i))^-1;
end

f22=-f22;
end
 




