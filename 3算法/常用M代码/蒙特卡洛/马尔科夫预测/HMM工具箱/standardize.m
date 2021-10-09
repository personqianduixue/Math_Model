function [S, mu, sigma2] = standardize(M, mu, sigma2)
% function S = standardize(M, mu, sigma2)
% Make each column of M be zero mean, std 1.
% Thus each row is scaled separately.
%
% If mu, sigma2 are omitted, they are computed from M

M = double(M);
if nargin < 2
  mu = mean(M,2);
  sigma2 = std(M,0,2);
  sigma2 = sigma2 + eps*(sigma2==0);
end

[nrows ncols] = size(M);
S = M - repmat(mu(:), [1 ncols]);
S = S ./ repmat(sigma2, [1 ncols]);

