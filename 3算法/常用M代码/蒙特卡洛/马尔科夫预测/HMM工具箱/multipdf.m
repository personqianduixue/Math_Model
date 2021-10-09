function p = multipdf(x,theta)
%MULTIPDF Multinomial probability density function.
%   p = multipdf(x,theta) returns the probabilities of 
%   vector x, under the multinomial distribution
%   with parameter vector theta.
%
%   Author: David Ross

%--------------------------------------------------------
% Check the arguments.
%--------------------------------------------------------
error(nargchk(2,2,nargin));

% make sure theta is a vector
if ndims(theta) > 2 | all(size(theta) > 1)
    error('theta must be a vector');
end

% make sure x is of the appropriate size
if ndims(x) > 2 | any(size(x) ~= size(theta))
    error('columns of X must have same length as theta');
end


%--------------------------------------------------------
% Main...
%--------------------------------------------------------
p = prod(theta .^ x);
p = p .* factorial(sum(x)) ./ prod(factorial_v(x));


%--------------------------------------------------------
% Function factorial_v(x): computes the factorial function
% on each element of x
%--------------------------------------------------------
function r = factorial_v(x)

if size(x,2) == 1
    x = x';
end

r = [];
for y = x
    r = [r factorial(y)];
end