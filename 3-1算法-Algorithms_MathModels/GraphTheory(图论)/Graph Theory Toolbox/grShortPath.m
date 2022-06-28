function [dSP,sp]=grShortPath(E,s,t)
% Function dSP=grShortPath(E) solve the task about
% the shortest path between any vertexes of digraph.
% Input parameter: 
%   E(m,2) or (m,3) - the arrows of digraph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of arrow;
%     m - number of arrows.
%     If we set the array E(m,2), then all weights is 1.
% Output parameter:
%   dSP(n,n) - the matrix of shortest path.
%   Each element dSP(i,j) is the shortest path 
%   from vertex i to vertex j (may be inf,
%   if vertex j is not accessible from vertex i).
% Uses the algorithm of R.W.Floyd, S.A.Warshall.
% [dSP,sp]=grShortPath(E,s,t) - find also
% the shortest paths from vertex s (source) to vertex t (tail).
% In this case output parameter sp is vector with numbers 
% of vertexes, included to shortest path from s to t.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru
% Acknowledgements to Prof. Gerard Biau 
% (Universite Montpellier II, France)
% for testing of this algorithm.

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation

% ================ Initial values ===============
dSP=ones(n)*inf; % initial distances
dSP((E(:,2)-1)*n+E(:,1))=E(:,3);

% ========= The main cycle of Floyd-Warshall algorithm =========
for j=1:n,
  i=setdiff((1:n),j);
  dSP(i,i)=min(dSP(i,i),repmat(dSP(i,j),1,n-1)+repmat(dSP(j,i),n-1,1));
end
sp=[];
if (nargin<3)|(isempty(s))|(isempty(t)),
  return
end
s=s(1);
t=t(1);
if (~(s==round(s)))|(~(t==round(t)))|(s<1)|(s>n)|(t<1)|(t>n),
  error(['s and t must be integer from 1 to ' num2str(n)])
end
if isinf(dSP(s,t)), % t is not accessible from s
  return
end
dSP1=dSP;
dSP1(1:n+1:n^2)=0; % modified dSP
l=ones(m,1); % label for each arrow
sp=t; % final vertex
while ~(sp(1)==s),
  nv=find((E(:,2)==sp(1))&l); % all labeled arrows to sp(1)
  vnv=abs((dSP1(s,sp(1))-dSP1(s,E(nv,1)))'-E(nv,3))<eps*1e3; % valided arrows
  l(nv(~vnv))=0; % labels of not valided arrows
  if all(~vnv), % invalided arrows
    l(find((E(:,1)==sp(1))&(E(:,2)==sp(2))))=0; 
    sp=sp(2:end); % one step back
  else
    nv=nv(vnv); % rested vaded arrows
    sp=[E(nv(1),1) sp]; % add one vertex to shortest path
  end
end
return