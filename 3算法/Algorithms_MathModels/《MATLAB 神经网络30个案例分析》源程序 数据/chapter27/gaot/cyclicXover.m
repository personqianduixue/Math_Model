function [c1,c2] = cyclicXover(p1,p2,bounds,Ops)
% Cyclic crossover takes two parents P1,P2 and performs cyclic
% crossover by Davis on permutation strings.  
%
% function [c1,c2] = cyclicXover(p1,p2,bounds,Ops)
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

sz = size(p1,2);
c1=zeros(1,sz);
c2=zeros(1,sz);
pt=find(p1==1);
while (c1(pt)==0)
  c1(pt)=p1(pt);
  pt=find(p1==p2(pt));
end
left=find(c1==0);
c1(left)=p2(left);

pt=find(p2==1);
while (c2(pt)==0)
  c2(pt)=p2(pt);
  pt=find(p2==p1(pt));
end
left=find(c2==0);
c2(left)=p1(left);