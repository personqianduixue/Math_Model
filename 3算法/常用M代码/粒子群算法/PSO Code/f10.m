function f10=f10(x)
Bound=[-32 32];

if nargin==0
    f10 = Bound;
else
    [Dim, PopSize] = size(x);
    indices = repmat(Dim, PopSize, 1)';
    f10 = -20*exp(-0.2*(sum(x.^2)./indices).^.5)-exp(sum(cos(2*pi.*x))./indices)+20+exp(1);
end