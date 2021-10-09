function fval = f5(x)
% Unimodal function f_1
% global ii
% ii=ii+1
Bound=[-30 30];

if nargin == 0
    fval = Bound;
else
    fval = 0;
    for i = 1:29
        fval = fval+(100*(x(i+1)-x(i)^2)^2+(x(i)-1))^2;
    end
end