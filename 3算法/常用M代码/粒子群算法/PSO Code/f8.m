function f8=f8(x)
Bound=[-500 500];

if nargin==0
    f8 = Bound;
else
    f8 = sum(-x.*sin(abs(x).^.5));
end