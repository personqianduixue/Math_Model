function nMS=grMinAbsEdgeSet(E)
% Function nMS=grMinAbsEdgeSet(E) solve the minimal absorbant set problem
%   for the graph edges.
% Input parameter: 
%   E(m,2) or (m,3) - the edges of graph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of edge;
%     m - number of edges.
%     If we set the array E(m,2), then all weights is 1.
% Output parameter:
%   nMS - the list of the numbers of edges included 
%     in the minimal (weighted) absorbant set of edges.
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
B=zeros(m);
for k=1:m,
  nn=find((E(:,1)==E(k,1))|(E(:,1)==E(k,2))| ...
          (E(:,2)==E(k,1))|(E(:,2)==E(k,2)));
  B(nn,k)=1;
  B(k,nn)=1;
end % adjacency matrix for edges + main diagonal
options=optimset('bintprog'); % the default options
options.Display='off'; % we change the output

% ============= We solve the MILP problem ==========
xmin=bintprog(E(:,3),-B,-ones(m,1),[],[],[],options);
nMS=find(round(xmin)); % the answer - numbers of vertexes
return