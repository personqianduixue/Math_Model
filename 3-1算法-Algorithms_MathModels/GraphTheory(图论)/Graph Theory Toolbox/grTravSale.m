function [pTS,fmin]=grTravSale(C)
% Function [pTS,fmin]=grTravSale(C) solve the nonsymmetrical
% traveling salesman problem.
% Input parameter: 
%   C(n,n) - matrix of distances between cities, 
%     maybe, nonsymmetrical;
%     n - number of cities.
% Output parameters: 
%   pTS(n) - the order of cities;
%   fmin - length of way.
% Uses the reduction to integer LP-problem:
% Look: Miller C.E., Tucker A. W., Zemlin R. A. 
% Integer Programming Formulation of Traveling Salesman Problems. 
% J.ACM, 1960, Vol.7, p. 326-329.
% Needed other products: MIQP.M.
% This software may be free downloaded from site:
% http://control.ee.ethz.ch/~hybrid/miqp/
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
if ~isnumeric(C),
  error('The array C must be numeric!') 
end
if ~isreal(C),
  error('The array C must be real!') 
end
s=size(C); % size of array C
if length(s)~=2,
  error('The array C must be 2D!') 
end
if s(1)~=s(2),
  error('Matrix C must be square!')
end
if s(1)<3,
  error('Must be not less than 3 cities!')
end

% ============ Size of problem ====================
n=s(1); % number of vertexes
m=n*(n-1); % number of arrows

% ============ Parameters of integer LP problem ========
Aeq=[]; % for the matrix of the boundary equations
for k1=1:n,
  z1=zeros(n);
  z1(k1,:)=1;
  z2=[z1;eye(n)];
  Aeq=[Aeq z2([1:2*n-1],setdiff([1:n],k1))];
end
Aeq=[Aeq zeros(2*n-1,n-1)];
A=[]; % for the matrix of the boundary inequations
for k1=2:n,
  z1=[];
  for k2=1:n,
    z2=eye(n)*(n-1)*(k2==k1);
    z1=[z1 z2(setdiff([2:n],k1),setdiff([1:n],k2))];
  end
  z2=-eye(n);
  z2(:,k1)=z2(:,k1)+1;
  A=[A;[z1 z2(setdiff([2:n],k1),2:n)]];
end
beq=ones(2*n-1,1); % the right parts of the boundary equations
b=ones((n-1)*(n-2),1)*(n-2); % the right parts of the boundary inequations
C1=C'+diag(ones(1,n)*NaN);
C2=C1(:);
c=[C2(~isnan(C2));zeros(n-1,1)]; % the factors for objective function
vlb=[zeros(m,1);-inf*ones(n-1,1)]; % the lower bounds
vub=[ones(m,1);inf*ones(n-1,1)]; % the upper bounds
H=zeros(n^2-1); % Hessian

% ============= We solve the MIQP problem ==========
[xmin,fmin]=MIQP(H,c,A,b,Aeq,beq,[1:m],vlb,vub);

% ============= We return the results ==============
eik=round(xmin(1:m)); % the arrows of the way
e1=[zeros(1,n-1);reshape(eik,n,n-1)];
e2=[e1(:);0]; % we add zero to a diagonal
e3=(reshape(e2,n,n))'; % the matrix of the way
pTS=[1 find(e3(1,:))]; % we build the way
while pTS(end)>1, % we add the city to the way
  pTS=[pTS find(e3(pTS(end),:))];
end
return