function [c1,c2]= oox(p1,p2,bounds,Ops)
% Orderbased crossover takes two parents P1,P2 and performs  order
% based crossover by Davis.  
%
% function [c1,c2] = orderbasedXover(p1,p2,bounds,Ops)
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
n=floor(sz/2);
cut1 = round(rand*(n-1)+0.5); %Generate random cut point U(1,n/2);
cut2 = round(rand*(sz-cut1-1)+1+cut1); %Generate random cut point U(cut1+1,n-1);
pm1=p1(1:end-1);
pm2=p2(1:end-1);
c1=p1;
c2=p2;
for i=[1:cut1 (cut2+1):sz]
  pm1=strrep(pm1,p2(i),-1);
  pm2=strrep(pm2,p1(i),-1);
end
c1((cut1+1):cut2)=p2(find(pm2>0));
c2((cut1+1):cut2)=p1(find(pm1>0));
