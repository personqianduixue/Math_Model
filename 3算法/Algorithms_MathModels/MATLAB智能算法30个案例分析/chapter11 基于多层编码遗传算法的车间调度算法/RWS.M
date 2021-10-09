% RWS.m - Roulette Wheel Selection
%
%       Syntax:
%               NewChrIx = rws(FitnV, Nsel)
%
%       This function selects a given number of individuals Nsel from a
%       population. FitnV is a column vector containing the fitness
%       values of the individuals in the population.
%
%       The function returns another column vector containing the
%       indexes of the new generation of chromosomes relative to the
%       original population matrix, shuffled. The new population, ready
%       for mating, can be obtained by calculating
%       OldChrom(NewChrIx, :).

% Author: Carlos Fonseca, 	Updated: Andrew Chipperfield
% Date: 04/10/93,		Date: 27-Jan-94

function NewChrIx = rws(FitnV,Nsel);

% Identify the population size (Nind)
[Nind,ans] = size(FitnV);

% Perform Stochastic Sampling with Replacement
cumfit  = cumsum(FitnV);
trials = cumfit(Nind) .* rand(Nsel, 1);
Mf = cumfit(:, ones(1, Nsel));
Mt = trials(:, ones(1, Nind))';
[NewChrIx, ans] = find(Mt < Mf & ...
                        [ zeros(1, Nsel); Mf(1:Nind-1, :) ] <= Mt);
