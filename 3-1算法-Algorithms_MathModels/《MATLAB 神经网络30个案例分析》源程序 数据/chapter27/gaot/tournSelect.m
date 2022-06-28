function[newPop] = tournSelect(oldPop,options)
% Performs a tournament selection.
%
% function[newPop] = tournSelect(oldPop,options)
% newPop  - the new population selected from the oldPop
% oldPop  - the current population
% options - options to normGeomSelect [gen tournament_size]

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

tournSize=options(2); 			% Get the number of tournaments
e = size(oldPop,2); 			% xZome length
n = size(oldPop,1); 			% number in Population
newPop = zeros(n,e); 			% Create the memory for newPop
tourns=floor(rand(tournSize,n)*n)+1; 	% Schedule of tournaments
% Determine the winner of the tournaments
[c b]=max(reshape(oldPop(tourns,e),tournSize,n));
newPop=oldPop(diag(tourns(b,:)),:); 	% Copy the winners in to newPop

