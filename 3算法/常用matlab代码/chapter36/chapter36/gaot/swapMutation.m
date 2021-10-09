function [child] = swapmutate(par,bounds,genInfo,Ops)
% Swap mutation exchanges the positions of two randomly
% chosen genes in a permutation
%
% function [newSol] = adjswapmutation(parent,bounds,Ops)
% parent  - the first parent ( [solution string function value] )
% bounds  - the bounds matrix for the solution space
% Ops     - Options for binaryMutation [gen prob_of_mutation]

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
sz = size(par,2)-1;
pos1 = round(rand*sz + 0.5);
pos2 = round(rand*sz + 0.5);
if pos1 ~= pos2
   if pos1 > pos2
      t = pos1; pos1 = pos2; pos2 = t;
   end
   child = [par(1:pos1-1) par(pos2) par(pos1+1:pos2-1) par(pos1) par(pos2+1:(sz+1))];
else
   child = par;
end
    
   
