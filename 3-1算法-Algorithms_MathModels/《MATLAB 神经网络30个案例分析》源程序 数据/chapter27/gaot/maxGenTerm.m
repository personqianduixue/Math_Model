function [done] = maxGenTerm(ops,bPop,endPop)
% function [done] = maxGenTerm(ops,bPop,endPop)
%
% Returns 1, i.e. terminates the GA when the maximal_generation is reached.
%
% ops    - a vector of options [current_gen maximum_generation]
% bPop   - a matrix of best solutions [generation_found solution_string]
% endPop - the current generation of solutions

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

currentGen = ops(1);
maxGen     = ops(2);
done       = currentGen >= maxGen; 