function f2=f2(x)
Bound=[-10 10];

if nargin==0
    f2 = Bound;
else
    f2=sum(abs(x))+prod(abs(x));
end