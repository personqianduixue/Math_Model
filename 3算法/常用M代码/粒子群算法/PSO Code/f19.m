function f19=f19(x)
Bound=[0 1];

if nargin==0
    f19 = Bound;
else
aij=[3 10 30;
    .1 10 35;
    3 10 30;
    .1 10 35];
ci=[1 1.2 3 3.2];
pij=[.3689 .1170 .2673; 
     .4699 .4387 .7470;
     .1091 .8732 .5547;
     .03815 .5743 .8828];
 
 X=[x x x x];
 
f19=-sum(ci.*exp(-sum(aij'.*(X-pij').^2)));
end
 
 




