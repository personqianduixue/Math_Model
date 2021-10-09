function mCol=grColEdge(E)
% function mCol=grColEdge(E) solve the color graph problem
% for edges of the graph.
% Input parameter: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
% Output parameter:
%   mCol(m,1) - the list of the colors of edges.
% Uses the sequential deleting of the maximal matching sets.
% Required the Optimization Toolbox v.3.0.1 or over.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation
E=[E(:,1:2),[1:m]']; % numbers of vertexes and numbers of edges
mCol=zeros(m,1); % initial value
% ============= Main cycle with MaxMatch deleting ====
while any(mCol==0),
  ne=find(mCol==0); % uncolored edges
  E1=E(ne,:); % it's edges
  nMM=grMaxMatch(E1(:,1:2)); % the maximal matching
  mCol(E1(nMM,3))=max(mCol)+1; % the next colorend
end
return