function[newPop] = normGeomSelect(oldPop,options)
% NormGeomSelect is a ranking selection function based on the normalized
% geometric distribution.  
%
% function[newPop] = normGeomSelect(oldPop,options)
% newPop  - the new population selected from the oldPop
% oldPop  - the current population
% options - options to normGeomSelect [gen probability_of_selecting_best]

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

q=options(2); 				% Probability of selecting the best
e = size(oldPop,2); 			% Length of xZome, i.e. numvars+fit
n = size(oldPop,1); 			% Number of individuals in pop
newPop = zeros(n,e); 			% Allocate space for return pop
fit = zeros(n,1); 			% Allocates space for prob of select
x=zeros(n,2); 			        % Sorted list of rank and id
x(:,1) =[n:-1:1]'; 			% To know what element it was
[y x(:,2)] = sort(oldPop(:,e)); 	% Get the index after a sort
r = q/(1-(1-q)^n); 			% Normalize the distribution, q prime
fit(x(:,2))=r*(1-q).^(x(:,1)-1); 	% Generates Prob of selection 
fit = cumsum(fit); 			% Calculate the cumulative prob. func
rNums=sort(rand(n,1)); 			% Generate n sorted random numbers
fitIn=1; newIn=1; 			% Initialize loop control
while newIn<=n 				% Get n new individuals
  if(rNums(newIn)<fit(fitIn)) 		
    newPop(newIn,:) = oldPop(fitIn,:); 	% Select the fitIn individual 
    newIn = newIn+1; 			% Looking for next new individual
  else
    fitIn = fitIn + 1; 			% Looking at next potential selection
  end
end
