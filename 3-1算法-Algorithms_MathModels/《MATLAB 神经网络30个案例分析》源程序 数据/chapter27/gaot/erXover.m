function [c1,c2]=er(p1,p2,bounds,ops)
% Er crossover takes two parents P1,P2 and performs edge recombination
% crossover on permutation strings.  
%
% function [c1,c2] = er(p1,p2,bounds,Ops)
% p1      - the first parent ( [solution string function value] )
% p2      - the second parent ( [solution string function value] )
% bounds  - the bounds matrix for the solution space
% Ops     - Options matrix for simple crossover [gen #SimpXovers].

% Binary and Real-Valued Simulation Evolution for Matlab 
% Copyright (C) 1996 C.R. Houck, J.A. Joines, M.G. Kay 
%
% C.R. Houck, J.Joines, and M.Kay. A genetic algorithm for function
% optimization: A Matlab implementation. ACM Transactions on Mathmatical
% Software, Submitted 1996.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
sz=size(p1,2)-1;
right=[2:sz 1];
left =[sz 1:(sz-1)];
p1i(p1)=1:sz; %Generate index
p2i(p2)=1:sz; %Generate index
adj=sort([-1:-1:-sz;p1(right(p1i));p1(left(p1i));p2(right(p2i));p2(left(p2i))])';
repeats=find(diff(adj(:,2:5)')'==0);
adj(repeats+sz)=zeros(size(repeats));

curr_site = round(rand*sz + 0.5); %Pick random start site
for site=1:(sz-1)
  c1(site)=curr_site;
  inAdj=find(adj(:,2:5)==curr_site); %Find this site in adjacency table
  adj(inAdj+sz)=zeros(size(inAdj)); %Take this out of the adjacency table
  %Find the element with fewest remaining links
  lz=colperm(adj');
  lzi(lz)=1:size(lz,2); %create index
  adj_cities=adj(curr_site,1+(find(adj(curr_site,2:5))));
  [v i]=min(lzi(adj_cities));
  curr_site=adj_cities(i);
end
c1(sz)=curr_site;
c2=p1;