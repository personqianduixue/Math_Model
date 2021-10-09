% CRTBASE.m - Create base vector 
%
% This function creates a vector containing the base of the loci
% in a chromosome.
%
% Syntax: BaseVec = crtbase(Lind, Base)
%
% Input Parameters:
%
%		Lind	- A scalar or vector containing the lengths
%			  of the alleles.  Sum(Lind) is the length of
%			  the corresponding chromosome.
%
%		Base	- A scalar or vector containing the base of
%			  the loci contained in the Alleles.
%
% Output Parameters:
%
%		BaseVec	- A vector whose elements correspond to the base
%			  of the loci of the associated chromosome structure.

% Author: Andrew Chipperfield
% Date: 19-Jan-94

function BaseVec = crtbase(Lind, Base)

[ml LenL] = size(Lind) ;
if nargin < 2 
	Base = 2 * ones(LenL,1) ; % default to base 2
end
[mb LenB] = size(Base) ;

% check parameter consistency
if ml > 1 | mb > 1
	error( 'Lind or Base is not a vector') ;
elseif (LenL > 1 & LenB > 1 & LenL ~= LenB) | (LenL == 1 & LenB > 1 ) 
	error( 'Vector dimensions must agree' ) ;
elseif LenB == 1 & LenL > 1
	Base = Base * ones(LenL,1) ;
	
end

BaseVec = [] ;
for i = 1:LenL
	BaseVec = [BaseVec, Base(i)*ones(Lind(i),1)'];
end
