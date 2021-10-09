function nMM=grMaxMatch(E)
% Function nMM=grMaxMath(E) solve the maximal matching problem.
% Input parameter: 
%   E(m,2) or (m,3) - the edges of graph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of edge;
%     m - number of edges.
%     If we set the array E(m,2), then all weights is 1.
% Output parameter:
%   nMM - the list of the numbers of edges included 
%     in the maximal (weighted) matching.
% Uses the reduction to integer LP-problem.
% Required the Optimization Toolbox v.3.0.1 or over.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation

% ============= Parameters of integer LP problem ==========
A=zeros(n,m); % for incidence matrix
A(E(:,1:2)+repmat(([1:m]'-1)*n,1,2))=1; % we fill the incidence matrix
options=optimset('bintprog'); % the default options
options.Display='off'; % we change the output

% ============= We solve the integer LP problem ==========
xmin=bintprog(-E(:,3),A,ones(n,1),[],[],[],options);
nMM=find(round(xmin)); % the answer - numbers of edges
return