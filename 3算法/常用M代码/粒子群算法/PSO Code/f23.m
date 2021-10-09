function f23=f23(x)
Bound=[0 10];

if nargin==0
    f23 = Bound;
else
aij=[4 4 4 4;
     1 1 1 1;
     8 8 8 8;
     6 6 6 6;
     3 7 3 7;
     2 9 2 9;
     5 5 3 3;
     8 1 8 1;
     6 2 6 2;
     7 3.6 7 3.6];
ci=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

 
f23=0;

for i=1:10
    f23=f23+(norm(x-aij(i,:)').^2+ci(:,i))^-1;
end

f23=-f23;
end 
 




