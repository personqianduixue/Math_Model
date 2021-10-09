% MUT.m
%
% This function takes the representation of the current population,
% mutates each element with given probability and returns the resulting
% population.
%
% Syntax:	NewChrom = mut(OldChrom,Pm,BaseV)
%
% Input parameters:
%
%		OldChrom - A matrix containing the chromosomes of the
%			   current population. Each row corresponds to
%			   an individuals string representation.
%
%		Pm	 - Mutation probability (scalar). Default value
%			   of Pm = 0.7/Lind, where Lind is the chromosome
%			   length is assumed if omitted.
%
%		BaseV	 - Optional row vector of the same length as the
%			   chromosome structure defining the base of the 
%			   individual elements of the chromosome. Binary
%			   representation is assumed if omitted.
%
% Output parameter:
%
%		NewChrom - A Matrix containing a mutated version of
%			   OldChrom.
%

% Author: Andrew Chipperfield
% Date: 25-Jan-94

function NewChrom = mut(OldChrom,Pm,BaseV)

% get population size (Nind) and chromosome length (Lind)
[Nind, Lind] = size(OldChrom) ;

% check input parameters
if nargin < 2, Pm = 0.7/Lind ; end
if isnan(Pm), Pm = 0.7/Lind; end

if (nargin < 3), BaseV = crtbase(Lind);  end
if (isnan(BaseV)), BaseV = crtbase(Lind);  end
if (isempty(BaseV)), BaseV = crtbase(Lind);  end

if (nargin == 3) & (Lind ~= length(BaseV))
   error('OldChrom and BaseV are incompatible'), end

% create mutation mask matrix
BaseM = BaseV(ones(Nind,1),:) ;

% perform mutation on chromosome structure
NewChrom = rem(OldChrom+(rand(Nind,Lind)<Pm).*ceil(rand(Nind,Lind).*(BaseM-1)),BaseM);
