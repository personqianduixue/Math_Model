% function fval = f6(x)
% % Unimodal function f_1
% 
% Bound = [-500 500];
% 
% if nargin == 0
%     fval = Bound;
% else
%     fval = sum(-x.*sin(abs(x).^.5));
% end
function fval=f6(x)
Bound=[-100 100];

if nargin==0
    fval = Bound;
else
    x=abs(floor(x+0.5));
    fval= sum(x);
end