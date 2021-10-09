function [PCcoeff, PCvec] = pca(data, N)
%PCA	Principal Components Analysis
%
%	Description
%	 PCCOEFF = PCA(DATA) computes the eigenvalues of the covariance
%	matrix of the dataset DATA and returns them as PCCOEFF.  These
%	coefficients give the variance of DATA along the corresponding
%	principal components.
%
%	PCCOEFF = PCA(DATA, N) returns the largest N eigenvalues.
%
%	[PCCOEFF, PCVEC] = PCA(DATA) returns the principal components as well
%	as the coefficients.  This is considerably more computationally
%	demanding than just computing the eigenvalues.
%
%	See also
%	EIGDEC, GTMINIT, PPCA
%

%	Copyright (c) Ian T Nabney (1996-2001)

if nargin == 1
   N = size(data, 2);
end

if nargout == 1
   evals_only = logical(1);
else
   evals_only = logical(0);
end

if N ~= round(N) | N < 1 | N > size(data, 2)
   error('Number of PCs must be integer, >0, < dim');
end

% Find the sorted eigenvalues of the data covariance matrix
if evals_only
   PCcoeff = eigdec(cov(data), N);
else
  [PCcoeff, PCvec] = eigdec(cov(data), N);
end

