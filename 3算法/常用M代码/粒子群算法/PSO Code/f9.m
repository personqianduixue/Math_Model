% function fval = f9(x)
% 
% Bound = [-600 600];
% 
% if nargin==0
%     fval = Bound;
% else
%     x = x';
%     fval = sum(x.^2)/1000-prod(cos(x./sqrt(1:30)))+1;
% end
%Rastrigin Function
function fval=f9(x)

Bound=[-5.12 5.12];

if nargin==0
    fval= Bound;
else
    [Dim, PopSize] = size(x);
    fval = sum(x.^2 - 10*cos(2*pi.*x)) + Dim*10;
end