function [ch1,ch2] = partmapXover(par1,par2,bounds,Ops)
% Partmap crossover takes two parents P1,P2 and performs a partially
% mapped crossover.  
%
% function [c1,c2] = partmapXover(p1,p2,bounds,Ops)
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
sz = size(par1,2)-1;
pos1 = round(rand*sz + 0.5);
pos2 = round(rand*sz + 0.5);
while pos2 == pos1
   pos2 = round(rand*sz + 0.5);
end
if pos1 > pos2
   t = pos1; pos1 = pos2; pos2 = t;
end    
ss1 = par1(pos1:pos2); ss2 = par2(pos1:pos2);
ch1 = par2; ch2 = par1;
for i = [1:pos1-1 pos2+1:sz]
   ch1(i) = par1(i);
   j = find(ch1(i) == ss2);
   while ~isempty(j)
      ch1(i) = ss1(j);
      j = find(ch1(i) == ss2);
   end
   ch2(i) = par2(i);
   j = find(ch2(i) == ss1);
   while ~isempty(j)
      ch2(i) = ss2(j);
      j = find(ch2(i) == ss1);
   end
end
