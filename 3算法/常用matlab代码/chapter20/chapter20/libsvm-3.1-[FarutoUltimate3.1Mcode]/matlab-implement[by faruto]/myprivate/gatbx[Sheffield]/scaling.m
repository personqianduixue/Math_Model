% SCALING.m - linear fitness scaling
%
% This function implements a linear fitness scaling algorithm as described
% by Goldberg in "Genetic Algorithms in Search, Optimization and Machine
% Learning", Addison Wesley, 1989.  It use is not recommended when fitness
% functions produce negative results as the scaling will become unreliable.
% It is included in this version of the GA Toolbox only for the sake of
% completeness.
%
% Syntax:	FitnV = scaling(ObjV, Smul)
%
% Input parameters:
%
%		Objv	- A vector containing the values of individuals
%			  fitness.
%
%		Smul	- Optional scaling parameter (default 2).
%
% Output parameters:
%
%		FitnV	- A vector containing the individual fitnesses
%			  for the current population.
%			  
%

% Author: Andrew Chipperfield
% Date: 24-Feb-94


function FitnV = scaling( ObjV, Smul )

if nargin == 1
	Smul = 2 ;
end

[Nind, Nobj] = size( ObjV ) ;
Oave = sum( ObjV ) / Nind ;
Omin = min( ObjV ) ;
Omax = max( ObjV ) ;

if (Omin > ( Smul * Oave - Omax ) / ( Smul - 1.0 ))
	delta = Omax - Oave 
	a = ( Smul - 1.0 ) * Oave / delta 
	b = Oave * ( Omax - Smul * Oave ) / delta 
else
	delta = Oave - Omin ;
	a = Oave / delta ;
	b = -Omin * Oave / delta ;
end

FitnV = ObjV.*a + b ;
