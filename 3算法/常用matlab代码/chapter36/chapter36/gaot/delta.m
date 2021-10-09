function[change] = delta(ct,mt,y,b)
% The delta function is the non-uniform distributions used by the nonUniform
% mutations.  This function returns a change based on the current gen, the
% max gen and the amount of possible deviation.
%
% function[change] = delta(ct,mt,y,b)
% ct - current generation
% mt - maximum generation
% y  - maximum amount of change, i.e. distance from parameter value to bounds
% b  - shape parameter

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

r=ct/mt;
if(r>1)
  r=.99;
  % disp(sprintf('max gen %d < current gen %d setting ratio = 1',mt,ct));
end
change = y*(rand*(1-r))^b;

