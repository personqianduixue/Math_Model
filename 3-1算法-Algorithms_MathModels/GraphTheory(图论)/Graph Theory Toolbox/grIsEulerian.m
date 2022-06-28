function [eu,cEu]=grIsEulerian(E)
% Function eu=grIsEulerian(E) returns 1 for Eulerian graph, 
% 0.5 for semi-Eulerian and 0 otherwise.
% Input parameter: 
%   E(m,2) - the edges of graph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of edges.
% Output parameter:
%   eu = 1 for Eulerian graph;
%   eu = 0.5 for semi-Eulerian graph;
%   eu = 0 otherwise.
% The graph is Eulerian, if he is connected and powers of 
% all vertexes is even.
% The graph is semi-Eulerian, if he is connected and only 
% two vertexes have odd powers, and other powers of vertexes is even.
% [eu,cEu]=grIsEulerian(E) return also 
%   cEu(m,1) - the vector-column with numbers of edges
%     included to Eulerian cycle (if eu=1) or Eulerian way (if eu=0.5)
%     and cEu=[] otherwise. The Fleury algorithm is used.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

if nargin<1,
  error('There are no input data!')
end
eu = 0; % the graph is not Eulerian
cEu=[];
ncV=grComp(E); % the number of components
if max(ncV)>1, % 2 or more components
  return % the graph is not Eulerian
end
n=max(max(E(:,1:2))); % number of vertexes
E1=find([diff(sort(E(:)));1]);
p=[E1(1);diff(E1)]; % powers of vertexes
rp=rem(p,2); % remainder after division to 2
srp=sum(rp); % summa of remainders
switch srp
  case 0, % Eulerian graph
    eu=1;
  case 2, % semi-Eulerian graph
    eu=0.5;
  otherwise, % not Eulerian graph
    return
end
%=========== we find the Eulerian cycle or way =============
if nargout>1,
  if srp==0, % Eulerian graph
    v1=1; % first vertex of Eulerian cycle
  else % semi-Eulerian graph
    v1=find(rp);
    v1=v1(1); % first vertex of Eulerian way
  end
  vc=v1; % the current vertex
  m=size(E,1); % number of edges
  E1=[E(:,1:2), [1:m]']; % all edges with numbers
  while ~isempty(E1), % the Fleury algorithm
    evc=find((E1(:,1)==vc)|(E1(:,2)==vc)); % edges connected with vc
    levc=length(evc); % number of edges connected with vertex vc
    if levc==1, % only one way
      cEu=[cEu;E1(evc,3)]; % we add new edge to Eulerian cycle (way)
      vcold=vc;
      vc=sum(E1(evc,1:2))-vc; % new current vertex
      E1=E1(setdiff([1:size(E1,1)],evc),:); % we delete isolated vertex
      E2=E1(:,1:2);
      E2gv=E2>vcold;
      E2(E2gv)=E2(E2gv)-1;
      E1(:,1:2)=E2;
      if vc>vcold,
        vc=vc-1;
      end
      if v1>vcold,
        v1=v1-1;
      end
    else % several ways from vertex vc
      for k=1:levc,
        E2=E1(setdiff([1:size(E1,1)],evc(k)),:);
        ncv=grComp(E2); % number of components
        nco=max(ncv);
        if (max(ncv)==1), % this edge is not bridge
          cEu=[cEu;E1(evc(k),3)]; % we add new edge to Eulerian cycle (way)
          vc=sum(E1(evc(k),1:2))-vc; % new current vertex
          E1=E2;
          break;
        end
      end
    end
  end
end
return