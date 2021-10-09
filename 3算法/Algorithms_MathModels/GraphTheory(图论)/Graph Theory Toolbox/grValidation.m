function [m,n,newE] = grValidation(E);
% The validation of array E - auxiliary function for GrTheory Toolbox.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

if ~isnumeric(E),
  error('The array E must be numeric!') 
end
if ~isreal(E),
  error('The array E must be real!') 
end
se=size(E); % size of array E
if length(se)~=2,
  error('The array E must be 2D!') 
end
if (se(2)<2),
  error('The array E must have 2 or 3 columns!')
end
if ~all(all(E(:,1:2)>0))
  error('1st and 2nd columns of the array E must be positive!')
end
if ~all(all((E(:,1:2)==round(E(:,1:2))))),
  error('1st and 2nd columns of the array E must be integer!')
end
m=se(1);
if se(2)<3, % not set the weight
  E(:,3)=1; % all weights =1
end
newE=E(:,1:3);
n=max(max(newE(:,1:2))); % number of vertexes
return