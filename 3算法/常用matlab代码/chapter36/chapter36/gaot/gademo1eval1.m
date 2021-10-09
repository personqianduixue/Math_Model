function [sol, val] = gaDemo1Eval(sol,options)
% Demonstration evaluation function used in gademo1.
% f(x)=x+10sin(5x)+7cos(4x)
%
% function [val,sol] = gaDemo1Eval(sol,options)
% 
% val - the fittness of this individual
% sol - the individual, returned to allow for Lamarckian evolution
% options - [current_generation]

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

x=sol(1);
val = x + 10*sin(5*x)+7*cos(4*x);
