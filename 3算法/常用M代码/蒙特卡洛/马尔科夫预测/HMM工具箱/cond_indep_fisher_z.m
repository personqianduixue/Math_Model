function [CI, r, p] = cond_indep_fisher_z(X, Y, S, C, N, alpha)
% COND_INDEP_FISHER_Z Test if X indep Y given Z using Fisher's Z test
% CI = cond_indep_fisher_z(X, Y, S, C, N, alpha)
%
% C is the covariance (or correlation) matrix
% N is the sample size
% alpha is the significance level (default: 0.05)
%
% See p133 of T. Anderson, "An Intro. to Multivariate Statistical Analysis", 1984

if nargin < 6, alpha = 0.05; end

r = partial_corr_coef(C, X, Y, S);
z = 0.5*log( (1+r)/(1-r) );
z0 = 0;
W = sqrt(N - length(S) - 3)*(z-z0); % W ~ N(0,1)
cutoff = norminv(1 - 0.5*alpha); % P(|W| <= cutoff) = 0.95
%cutoff = mynorminv(1 - 0.5*alpha); % P(|W| <= cutoff) = 0.95
if abs(W) < cutoff
  CI = 1;
else % reject the null hypothesis that rho = 0
  CI = 0;
end
p = normcdf(W);
%p = mynormcdf(W);

%%%%%%%%%

function p = normcdf(x,mu,sigma)
%NORMCDF Normal cumulative distribution function (cdf).
%   P = NORMCDF(X,MU,SIGMA) computes the normal cdf with mean MU and
%   standard deviation SIGMA at the values in X.
%
%   The size of P is the common size of X, MU and SIGMA. A scalar input  
%   functions as a constant matrix of the same size as the other inputs.    
%
%   Default values for MU and SIGMA are 0 and 1 respectively.

%   References:
%      [1]  M. Abramowitz and I. A. Stegun, "Handbook of Mathematical
%      Functions", Government Printing Office, 1964, 26.2.

%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 1.1 $  $Date: 2005/04/26 02:29:17 $

if nargin < 3, 
    sigma = 1;
end

if nargin < 2;
    mu = 0;
end

[errorcode x mu sigma] = distchck(3,x,mu,sigma);

if errorcode > 0
    error('Requires non-scalar arguments to match in size.');
end

%   Initialize P to zero.
p = zeros(size(x));

% Return NaN if SIGMA is not positive.
k1 = find(sigma <= 0);
if any(k1)
    tmp   = NaN;
    p(k1) = tmp(ones(size(k1))); 
end

% Express normal CDF in terms of the error function.
k = find(sigma > 0);
if any(k)
    p(k) = 0.5 * erfc( - (x(k) - mu(k)) ./ (sigma(k) * sqrt(2)));
end

% Make sure that round-off errors never make P greater than 1.
k2 = find(p > 1);
if any(k2)
    p(k2) = ones(size(k2));
end

%%%%%%%%

function x = norminv(p,mu,sigma);
%NORMINV Inverse of the normal cumulative distribution function (cdf).
%   X = NORMINV(P,MU,SIGMA) finds the inverse of the normal cdf with
%   mean, MU, and standard deviation, SIGMA.
%
%   The size of X is the common size of the input arguments. A scalar input  
%   functions as a constant matrix of the same size as the other inputs.    
%
%   Default values for MU and SIGMA are 0 and 1 respectively.

%   References:
%      [1]  M. Abramowitz and I. A. Stegun, "Handbook of Mathematical
%      Functions", Government Printing Office, 1964, 7.1.1 and 26.2.2

%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 1.1 $  $Date: 2005/04/26 02:29:17 $

if nargin < 3, 
    sigma = 1;
end

if nargin < 2;
    mu = 0;
end

[errorcode p mu sigma] = distchck(3,p,mu,sigma);

if errorcode > 0
    error('Requires non-scalar arguments to match in size.');
end

% Allocate space for x.
x = zeros(size(p));

% Return NaN if the arguments are outside their respective limits.
k = find(sigma <= 0 | p < 0 | p > 1);
if any(k)
    tmp  = NaN;
    x(k) = tmp(ones(size(k))); 
end

% Put in the correct values when P is either 0 or 1.
k = find(p == 0);
if any(k)
    tmp  = Inf;
    x(k) = -tmp(ones(size(k)));
end

k = find(p == 1);
if any(k)
    tmp  = Inf;
    x(k) = tmp(ones(size(k))); 
end

% Compute the inverse function for the intermediate values.
k = find(p > 0  &  p < 1 & sigma > 0);
if any(k),
    x(k) = sqrt(2) * sigma(k) .* erfinv(2 * p(k) - 1) + mu(k);
end
