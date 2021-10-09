function H = entropy(v, scale)
% ENTROPY Entropy log base 2
% H = entropy(v)
% If v is a matrix, we compute the entropy of each column
%
% % H = entropy(v,1) means we scale the result so that it lies in [0,1]

if nargin < 2, scale = 0; end

v = v + (v==0);
H = -1 * sum(v .* log2(v), 1); % sum the rows

if scale
  n = size(v, 1);
  unif = normalise(ones(n,1));
  H = H / entropy(unif);
end
