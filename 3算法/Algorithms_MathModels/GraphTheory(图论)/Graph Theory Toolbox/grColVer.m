function nCol=grColVer(E)
% function nCol=grColVer(E) solve the color graph problem
% for vertexes of the graph.
% Input parameter: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
% Output parameter:
%   nCol(n,1) - the list of the colors of vertexes.
% Uses the sequential deleting of the maximal stable sets.
% Required the Optimization Toolbox v.3.0.1 or over.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
[m,n,E] = grValidation(E); % E data validation
E=sort(E(:,1:2)')'; % each row in ascending order
E=unique(E,'rows'); % we delete multiple edges
E=E(setdiff([1:size(E,1)]',find((E(:,1)==E(:,2)))),:); % we delete loops
nCol=zeros(n,1); % initial value
% ============= Main cycle with MaxStabSet deleting ====
while any(nCol==0),
  nv=find(nCol==0); % uncolored vertexes
  E1=E(find(ismember(E(:,1),nv)&ismember(E(:,2),nv)),:); % it's edges
  if isempty(E1),
    nCol(find(nCol==0))=max(nCol)+1; % the last color
    break;
  end
  nvs=unique(E1(:)); % all vertexes
  for kk=1:length(nvs),
    E1(find(E1==nvs(kk)))=kk;
  end
  nMS=grMaxStabSet(E1); % the maximal stable set
  nCol(nvs(nMS))=max(nCol)+1; % the next color
end
return