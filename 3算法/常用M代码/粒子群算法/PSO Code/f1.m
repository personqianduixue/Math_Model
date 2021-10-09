function fval = f1(x)
% Unimodal function f_1

Bound=[-100 100];

if nargin == 0
    fval = Bound;
else
    fval = sum(x.^2);
end


