function [CrP,Ts,Td]=grPERT(E)
% Function [CrP,Ts,Td]=grPERT(E) solve
% the project evaluation research task.
% Input parameter: 
%   E(m,2) or (m,3) - the arrows of digraph 
%     and their weight (working time);
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of arrow;
%     m - number of arrows.
%     If we set the array E(m,2), then all weights is 1.
% The digraph E must be acyclic.
% Output parameters:
%   CrP - the critical path (vector-row with numbers of vertexes);
%   Ts(1,n) - the start times for each vertex (event);
%   max(Ts) is length of critical path;
%   Td(m,1) - the delay times for each arrow (work).
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

[Dec,Ord]=grDecOrd(E); % the decomposition and partial ordering
n=max(max(E(:,1:2))); % number of vertexes (events)
m=size(E,1); % number of arrows (works)
if size(Dec,2)<n,
  error('The digraph is cyclic!')
end
s=find(Dec(:,1)); % the first event
t=find(Dec(:,end)); % the last event
Em=[E(:,1:2) -E(:,3)]; % weight with minus
[dSP,CrP]=grShortPath(Em,s,t); % the shortest path
Ts=-dSP(s,:); % the start time for each vertex (event)
Ts(find(isinf(Ts)))=0; % change inf to 0
Td=(Ts(E(:,2))-Ts(E(:,1)))'-E(:,3); % the time of delay for each work
return
