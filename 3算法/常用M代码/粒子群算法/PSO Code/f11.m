% function fval = f11(x)
% 
% Bound = [-65.536 65.536];
% 
% if nargin==0
%     fval = Bound;
% else
%     data = [-32 -16   0  16  32 ...
%             -32 -16   0  16  32 ...
%             -32 -16   0  16  32 ...
%             -32 -16   0  16  32 ...
%             -32 -16   0  16  32;
%             -32 -32 -32 -32 -32 ...
%             -16 -16 -16 -16 -16 ...
%               0   0   0   0   0 ...
%              16  16  16  16  16 ...
%              32  32  32  32  32];
%     fval = 1/(1/500+sum(1./((x(1)-data(1,:)).^6+(x(2)-data(2,:)).^6+(1:25)))); 
% end
function fval =f11(x)

Bound=[-600 600];

if nargin==0
   fval = Bound;
else
    [Dim, PopSize] = size(x);
    indices = repmat(1:Dim, PopSize, 1);
    fval  = .00025*sum((x-100).^2) - prod( cos((x-100)./sqrt(indices')) ) +1;
end