function x = sample(p, n)
% SAMPLE    Sample from categorical distribution.
% Returns a row vector of integers, sampled according to the probability
% distribution p.
% Uses the stick-breaking algorithm.
% Much faster algorithms are also possible.

if nargin < 2
  n = 1;
end

cdf = cumsum(p(:));
for i = 1:n
  x(i) = sum(cdf < rand) + 1;
end
