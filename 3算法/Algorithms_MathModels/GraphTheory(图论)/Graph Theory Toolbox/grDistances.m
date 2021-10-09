function [dSP,sp]=grDistances(E,s,t)
% Function dSP=grDistances(E) find the distances
% between any vertexes of graph.
% Input parameter: 
%   E(m,2) or (m,3) - the edges of graph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of arrow;
%     m - number of arrows.
%     If we set the array E(m,2), then all weights is 1.
% Output parameter:
%   dSP(n,n) - the symmetric matrix of destances between 
%     all vertexes (may be dSP(i,j)=inf for disconnected graph).
% [dSP,sp]=grDistances(E,s,t) - find also
% the shortest way between vertexes s and t.
% In this case output parameter sp is vector with numbers 
% of vertexes, included to shortest way between s and t.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation

Ev=[E;E(:,[2 1 3])]; % all arrows and vice versa
sp=[];
if (nargin<3)|(isempty(s))|(isempty(t)),
  dSP=grShortPath(Ev); % the shortest path
else
  s=s(1);
  t=t(1);
  if s==t, % the trivial way
    dSP=grShortPath(Ev); % the shortest path
    sp=s;
  else
    [dSP,sp]=grShortPath(Ev,s,t);
  end
end
dSP=dSP-diag(diag(dSP)); % we delete the main diagonal
return