function CoCycles=grCoCycleBasis(E)
% Function CoCycles=grCoCycleBasis(E) find 
% the cocycle basis for a connected simple graph
% without loops and multiple edges
% (fundamental set of cut-sets).
% For loops and multiple edges you need add new vertexes.
% Input parameter: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
% Output parameter:
%   CoCycles(m,n-1) - the Boolean array with numbers of edges.
%     n - number of vertexes;
%     n-1 - number of independent cocycles.
%     In each column of the array CoCycles True value have
%     numbers of edges of this cocycle.
% Uses the deletion one edge from spanning tree.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

nMST=grMinSpanTree(E); % data validation and minimal spanning tree
E=E(:,1:2); % only numbers of vertexes
Emst=E(nMST,:); % edges of minimal spanning tree
m=size(E,1); % number of edges
n=max(max(E)); % number of vertexes
CoCycles=zeros(m,n-1); % array for cocycles
for k1=1:n-1, % we add one independent cocycle
  ncV=grComp(Emst(setdiff([1:n-1],k1),:),n); % two components
  n1=find(ncV==1); % the vertexes of 1st component
  n2=find(ncV==2); % the vertexes of 2nd component
  CoCycles(find((ismember(E(:,1),n1)&ismember(E(:,2),n2))|...
    (ismember(E(:,1),n2)&ismember(E(:,2),n1))),k1)=1;
end
return