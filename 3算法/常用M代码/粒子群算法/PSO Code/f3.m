function f3=f3(x)
Bound=[-100 100];

if nargin==0
    f3 = Bound;
else
    f3=sum(cumsum(x).^2);
end