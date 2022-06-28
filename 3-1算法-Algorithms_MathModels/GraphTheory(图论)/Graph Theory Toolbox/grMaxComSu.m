function nMS=grMaxComSu(E,d)
% Function nMS=grMaxComSu(E,d) solve the maximal complete sugraph (clique) problem.
% Input parameters: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
%   d(n) (optional) - the weights of vertexes,
%     n - number of vertexes.
%     If we have only 1st parameter E, then all d=1.
% Output parameter:
%   nMS - the list of the numbers of vertexes included 
%     in the maximal (weighted) complete sugraph.
% Uses the reduction to integer LP-problem.
% Required the Optimization Toolbox v.3.0.1 or over.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation
E=sort(E(:,1:2)')'; % each row in ascending order
E=unique(E,'rows'); % we delete multiple edges
E=E(setdiff([1:size(E,1)]',find((E(:,1)==E(:,2)))),:); % we delete loops
m=size(E,1);
n=max(max(E));
k1=repmat([1:n],n,1);
k2=k1';
K=[k1(:) k2(:)];
K1=reshape(K(2:end,:),n+1,2*(n-1));
K=unique(sort(reshape(K1(1:end-1,:),n*(n-1),2),2),'rows'); % clique
E1=setdiff(K,E,'rows'); % rested
if nargin<2, % we have only 1st parameter
  d=ones(n,1); % all weights =1
else
  d=d(:); % reshape to vector-column
  if length(d)<n, % the poor length
    error('The length of the vector d is poor!')
  else
    d=d(1:n); % First n numbers
  end
end
nMS=grMaxStabSet(E1,d); % the maximal stable set problem for graph G(V,~E)
return