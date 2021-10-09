function [parent] = multiNonUnifMutation(parent,bounds,Ops)
% Multi-Non uniform mutation changes all of the parameters of the parent
% based on a non-uniform probability distribution.  This Gaussian
% distribution starts wide, and narrows to a point distribution as the
% current generation approaches the maximum generation.
%
% function [newSol] = multiNonUnifMutate(parent,bounds,Ops)
% parent  - the first parent ( [solution string function value] )
% bounds  - the bounds matrix for the solution space
% Ops     - Options for multiNonUnifMutation 
%          [gen #MultiNonUnifMutations maxGen b]

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

cg=Ops(1); 				% Current Generation
mg=Ops(3); 				% Maximum Number of Generations
b=Ops(4);                               % Shape parameter
df = bounds(:,2) - bounds(:,1); 	% Range of the variables
numVar = size(parent,2)-1; 		% Get the number of variables
% Now mutate that point
md = round(rand(1,numVar));
for i = 1:numVar
  if md(i)
    parent(i)=parent(i)+delta(cg,mg,bounds(i,2)-parent(i),b);
  else
    parent(i)=parent(i)-delta(cg,mg,parent(i)-bounds(i,1),b);
  end
end
