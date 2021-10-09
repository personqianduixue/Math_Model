function [c1,c2] = heuristicXover(p1,p2,bounds,Ops)
% Heuristic crossover takes two parents P1,P2 and performs an extrapolation
% along the line formed by the two parents outward in the direction of the
% better parent.
%
% function [c1,c2] = heuristicXover(p1,p2,bounds,Ops)
% p1      - the first parent ( [solution string function value] )
% p2      - the second parent ( [solution string function value] )
% bounds  - the bounds matrix for the solution space
% Ops     - Options for heuristic crossover, [gen #heurXovers number_of_retries]

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

retry=Ops(3); 				% Number of retries
i=0;
good=0;
b1=bounds(:,1)';
b2=bounds(:,2)';
numVar = size(p1,2)-1;
% Determine the best and worst parent
if(p1(numVar+1) > p2(numVar+1))
  bt = p1; 
  wt = p2;
else
  bt = p2;
  wt = p1;
end
while i<retry
  % Pick a random mix amount
  a = rand;
  % Create the child
  c1 = a * (bt - wt) + bt;
  
  % Check to see if child is within bounds
  if (c1(1:numVar) <= b2 & (c1(1:numVar) >= b1))
    i = retry;
    good=1;
  else
    i = i + 1;
  end
end

% If new child is not feasible just return the new children
if(~good) 
  c1 = wt;
end

% Crossover functions return two children therefore return the best
% and the new child created
c2 = bt;

