function [ch1,ch2,t] = uniformxover(par1,par2,bounds,Ops)
% Uniform crossover takes two parents P1,P2 and performs uniform
% crossover on a permuation string.  
%
% function [c1,c2] = linearOrderXover(p1,p2,bounds,Ops)
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
ch1 = par1;
ch2 = par2;
t = round(rand(1,sz));
szt = sum(t);
idx = 1:sz;
idxt = idx(logical(t));
plst = idxt;
for i = 1:szt
   plst(i) = find(par2 == par1(idxt(i)));
end
plst = sort(plst);
for i = 1:szt
   ch1(idxt(i)) = par2(plst(i));
end
szt = sz - szt;
idxt = idx(~t);
plst = idxt;
for i = 1:szt
   plst(i) = find(par1 == par2(idxt(i)));
end
plst = sort(plst);
for i = 1:szt
   ch2(idxt(i)) = par1(plst(i));
end
 
   
