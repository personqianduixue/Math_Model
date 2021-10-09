function r = multirnd(theta,k)
%MULTIRND - Random vector from multinomial distribution.
%   r = multirnd(theta,k) returns a vector randomly selected
%   from the multinomial distribution with parameter vector
%   theta, and count k (i.e. sum(r) = k).
%
%   Note: if k is unspecified, then it is assumed k=1.
%
%   Author: David Ross
%

%--------------------------------------------------------
% Check the arguments.
%--------------------------------------------------------
error(nargchk(1,2,nargin));

% make sure theta is a vector
if ndims(theta) > 2 | all(size(theta) > 1)
    error('theta must be a vector');
end

% if theta is a row vector, convert it to a column vector
if size(theta,1) == 1
    theta = theta';
end

% make sure k is a scalar?

% if the number of samples has not been provided, set
% it to one
if nargin == 1
    k = 1;
end


%--------------------------------------------------------
% Main...
%--------------------------------------------------------
n = length(theta);
theta_cdf = cumsum(theta);

r = zeros(n,1);
random_vals = rand(k,1);

for j = 1:k
    index = min(find(random_vals(j) <= theta_cdf));
    r(index) = r(index) + 1;
end