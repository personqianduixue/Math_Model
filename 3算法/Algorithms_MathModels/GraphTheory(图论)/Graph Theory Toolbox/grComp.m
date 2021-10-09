function ncV=grComp(E,n)
% Function ncV=grComp(E,n) find all components of the graph.
% Input parameter: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
%   n - number of vertexes ( optional, by default n=max(max(E)) ).
%     This input parameter is needed, if last vertexes is isolated.
% Output parameter:
%   ncV(n,1) - the the vector-column with the number of component 
%     for each vertex;
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

if nargin<1,
  error('There are no input data!')
end
[m,n1,E1] = grValidation(E); % data validation
E2=[E1(:,1:2);E1(:,[2 1])]; % all arrows and vice versa
[Dec,Ord]=grDecOrd(E2); % the components
ncV=sum(Dec*diag([1:size(Dec,2)]),2); % the numbers of components
if (nargin>1)&(n>n1), % last isolated vertexes
  ncV=[ncV;[1:n-n1]'+max(ncV)];
end
return