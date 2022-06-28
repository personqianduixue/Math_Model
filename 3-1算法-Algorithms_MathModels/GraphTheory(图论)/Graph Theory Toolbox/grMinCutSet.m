function [nMCS,mf]=grMinCutSet(E,s,t)
% Function [nMCS,mf]=grMinCutSet(E,s,t) find the first 
% minimal cut-sets of the network.
% Input parameters: 
%   E(m,2) or (m,3) - the arrows of digraph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of arrow;
%     m - number of arrows.
%     If we set the array E(m,2), then all weights is 1.
%   s - input (source) of the network (number of vertex);
%   t - output (sink) of the network (number of vertex).
% Output parameters: 
%   nMCS(ncs) - the list of the numbers of arrows included 
%     in first minimal cut-set; ncs - number of of arrows
%     of the minimal cut-sets.
%   mf - the total flow through each minimal cut-set.
% Uses the reduction to maximal flow problem.
% Required the Optimization Toolbox
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

[v,mf]=grMaxFlows(E,s,t); % the maximal flow
[m,n,E] = grValidation(E); % E data validation
ecs=find((abs(v)<1e-8)|(abs(E(:,3)-v)<1e-8)); % v=0 or v=E(:,3);
E1=E(setdiff([1:m]',ecs),1:2);
E1=[E1;fliplr(E1)]; % all arrows
d=grDecOrd(E1); % strongly connected components
nd1=n-size(d,1); % number of terminal vertexes
d(size(d,1)+1:size(d,1)+nd1,size(d,2)+1:size(d,2)+nd1)=eye(nd1);
nz=rem(find(d'),size(d,2)); % number of zone for each vertex
nz(find(nz==0))=size(d,2);
Ecsn=sort(nz(E(ecs,1:2))')'; % numbers of connected zones
nMCS=ecs(find((Ecsn(:,1)==nz(s))|(Ecsn(:,2)==nz(s)))); % first cut-set
return