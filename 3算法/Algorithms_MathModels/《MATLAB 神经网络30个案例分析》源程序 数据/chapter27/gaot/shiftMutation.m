function [child] = shiftMutation(par,bounds,genInfo,Ops)
% Shift mutation performs displaces one random gene
% in a permutation to another position.
%
% function [newSol] =  shiftMutation(parent,bounds,Ops)
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
ppos = round(rand*sz + 0.5);
cpos = round(rand*sz + 0.5);
if ppos ~= cpos
   if ppos > cpos
      child = [par(1:cpos-1) par(ppos) par(cpos:ppos-1) par(ppos+1:sz) par(sz+1)];
   else
      child = [par(1:ppos-1) par(ppos+1:cpos) par(ppos) par(cpos+1:sz) par(sz+1)];
   end
else
   child = par;
end
    
   
