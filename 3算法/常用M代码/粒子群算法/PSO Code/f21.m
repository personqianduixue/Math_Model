function f21=f21(x)
Bound=[0 10];

if nargin==0
    f21 = Bound;
else
aij=[4 4 4 4;
     1 1 1 1;
     8 8 8 8;
     6 6 6 6;
     3 7 3 7];
ci=[.1 .2 .2 .4 .4];

f21=0;

for i=1:5
    f21=f21+(norm(x-aij(i,:)').^2+ci(:,i))^-1;
end

f21=-f21;

end
 
 




