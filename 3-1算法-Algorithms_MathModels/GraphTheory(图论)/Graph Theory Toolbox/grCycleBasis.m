function Cycles=grCycleBasis(E)
% Function Cycles=grCycleBasis(E) find 
% all independent cycles for a connected simple graph
% without loops and multiple edges
% (fundamental set of circuits).
% For loops and multiple edges you need add new vertexes.
% Input parameter: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
% Output parameter:
%   Cycles(m,m-n+1) - the Boolean array with numbers of edges.
%     n - number of vertexes;
%     m-n+1 - number of independent cycles.
%     In each column of the array Cycles True value have
%     numbers of edges of this cycle.
% Uses the addition of one edge to the spanning tree and deleting of tails.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

nMST=grMinSpanTree(E); % data validation and minimal spanning tree
E=sort(E(:,1:2)')'; % only numbers of vertexes
m=size(E,1); % number of edges
n=max(max(E)); % number of vertexes
Erest=E(setdiff([1:m],nMST),:); % rested edges
nr=m-n+1; % number of rested edges
Cycles=zeros(m,nr); % array for cycles
for k1=1:nr, % we add one independent cycle
  Ecurr=[E(nMST,:);Erest(k1,:)]; % spanning tree + one edge
  A=zeros(n);
  A((Ecurr(:,1)-1)*n+Ecurr(:,2))=1;
  A=A+A'; % the connectivity matrix
  p=sum(A); % the vertexes power
  nv=[1:n]; % numbers of vertexes
  while any(p==1), % we delete all tails
    nc=find(p>1); % rested vertexes
    A=A(nc,nc); % new connectivity matrix
    nv=nv(nc); % rested numbers of vertexes
    p=sum(A); % new powers
  end
  [i1,j1]=find(A);
  incedg=nv(unique(sort([i1 j1]')','rows')); % included edges
  Cycles(:,k1)=ismember(E,incedg,'rows'); % current column
end
return