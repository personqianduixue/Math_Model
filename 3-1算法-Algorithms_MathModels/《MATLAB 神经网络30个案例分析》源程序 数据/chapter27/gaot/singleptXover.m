function [c1,c2]= singlePtX(p1,p2,bounds,Ops)
% function [c1,c2] = singlePtXover(p1,p2,bounds,Ops)
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
cut = round(rand*(sz-1)+0.5); %Generate random cut point U(1,n-1)
pm1=p1(1:sz);
pm2=p2(1:sz);
c1=p1;
c2=p2;
c1(1:cut)=p1(1:cut);
c2(1:cut)=p2(1:cut);
for i=1:cut
  pm1=strrep(pm1,p2(i),-1);
  pm2=strrep(pm2,p1(i),-1);
end
c1((cut+1):sz)=p2(find(pm2>0));
c2((cut+1):sz)=p1(find(pm1>0));
