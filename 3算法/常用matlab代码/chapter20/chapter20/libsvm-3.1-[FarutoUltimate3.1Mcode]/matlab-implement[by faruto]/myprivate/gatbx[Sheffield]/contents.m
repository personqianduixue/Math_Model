% Genetic Algorithm Toolbox.
% Version 1.2 15-Apr-94
% Department of Automatic Control and Systems Engineering
% University of Sheffield, England
%
% Creating populations
%   crtbase	- create a base vector
%   crtbp	- create a binary population
%   crtrp	- create a real-valued population
%   
% Fitness assignment
%   ranking	- rank-based fitness assignment
%   scaling	- proportional fitness-scaling
%   
% Selection and reinsertion
%   reins	- uniform random and fitness-based reinsertion
%   rws		- roulette wheel selection
%   select	- high-level selection routine
%   sues		- stochastic universal sampling
%   
% Mutation operators
%   mut		- discrete mutation
%   mutate	- high-level mutation function
%   mutbga	- real-value mutation
%   
% Crossover operators
%   recdis	- discrete recombination
%   recint	- intermediate recombination
%   reclin	- line recombination
%   recmut	- line recombination with mutation features
%   recombin	- high-level recombination function
%   xovdp	- double-point crossover
%   xovdprs	- double-point reduced surrogate crossover
%   xovmp	- general multi-point crossover
%   xovsh	- shuffle crossover
%   xovshrs	- shuffle reduced surrogate crossover
%   xovsp	- single-point crossover
%   xovsprs	- single-point reduced surrogate crossover
%   
% Subpopulation support
%   migrate	- exchange individuals between subpopulations
%   
%   
% Utility functions
%   bs2rv	- binary string to real-value conversion
%   rep		- matrix replication
%   
% Demonstration and other functions
%   mpga	- multi-population genetic algorithm demonstration
%   objfun1	- De Jongs first test function (used by sga)
%   objharv	- harvest function (used in mpga)
%   resplot	- result plotting (used in mpga)
%   sga		- simple genetic algorithm demonstration 
