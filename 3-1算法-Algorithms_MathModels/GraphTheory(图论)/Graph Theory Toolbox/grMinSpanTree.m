function nMST=grMinSpanTree(E)
% Function nMST=grMinSpanTree(E) solve 
% the minimal spanning tree problem for a connected graph.
% Input parameter: 
%   E(m,2) or (m,3) - the edges of graph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of edge;
%     m - number of edges.
%     If we set the array E(m,2), then all weights is 1.
% Output parameter:
%   nMST(n-1,1) - the list of the numbers of edges included 
%     in the minimal (weighted) spanning tree in the including order.
% Uses the greedy algorithm.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation

% ============= The data preparation ==================
En=[(1:m)',E]; % we add the numbers
En(:,2:3)=sort(En(:,2:3)')'; % edges on increase order
ln=find(En(:,2)==En(:,3)); % the loops numbers
En=En(setdiff([1:size(En,1)]',ln),:); % we delete the loops
[w,iw]=sort(En(:,4)); % sort by weight
Ens=En(iw,:); % sorted edges

% === We build the minimal spanning tree by the greedy algorithm ===
Emst=Ens(1,:); % 1st edge include to minimal spanning tree
Ens=Ens(2:end,:); % rested edges
while (size(Emst,1)<n-1)&(~isempty(Ens)),
  Emst=[Emst;Ens(1,:)]; % we add next edge to spanning tree
  Ens=Ens(2:end,:); % rested edges
  if any((Emst(end,2)==Emst(1:end-1,2))&...
         (Emst(end,3)==Emst(1:end-1,3))) | ...
     IsCycle(Emst(:,2:3)), % the multiple edge or cycle
    Emst=Emst(1:end-1,:); % we delete the last added edge
  end
end
nMST=Emst(:,1); % numbers of edges
return

function ic=IsCycle(E); % true, if graph E have cycle
n=max(max(E)); % number of vertexes
A=zeros(n);
A((E(:,1)-1)*n+E(:,2))=1;
A=A+A'; % the connectivity matrix
p=sum(A); % the vertexes power
ic=false;
while any(p<=1), % we delete all tails
  nc=find(p>1); % rested vertexes
  if isempty(nc),
    return
  end
  A=A(nc,nc); % new connectivity matrix
  p=sum(A); % new powers
end
ic=true;
return