function [parent] = boundaryMutate(parent,bounds,Ops)
% Boundary Mutation changes one of the parameters of the parent and changes it
% randomly either to its upper or lower bound.
%
% function [newSol] = boundaryMutate(parent,bounds,Ops)
% parent  - the first parent ( [solution string function value] )
% bounds  - the bounds matrix for the solution space
% Ops     - Options for boundaryMutation [gen #BndMutations]

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

numVar = size(parent,2)-1; 		% Get the number of variables
% Pick a variable to mutate randomly from 1-number of vars
mPoint = round(rand * (numVar-1)) + 1;
b = round(rand)+1; 			% Pick which bound to move to
newValue = bounds(mPoint,b); 		% Now mutate that point
parent(mPoint) = newValue; 		% Make the child

