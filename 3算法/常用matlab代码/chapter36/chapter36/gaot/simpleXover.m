function [c1,c2] = simpleXover(p1,p2,bounds,Ops)
% Simple crossover takes two parents P1,P2 and performs simple single point
% crossover.  
%
% function [c1,c2] = simpleXover(p1,p2,bounds,Ops)
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

numVar = size(p1,2)-1; 			% Get the number of variables 
% Pick a cut point randomly from 1-number of vars
cPoint = round(rand * (numVar-2)) + 1;

c1 = [p1(1:cPoint) p2(cPoint+1:numVar+1)]; % Create the children
c2 = [p2(1:cPoint) p1(cPoint+1:numVar+1)];
