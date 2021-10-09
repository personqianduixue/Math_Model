function kl = cross_entropy(p, q, symmetric)
% CROSS_ENTROPY Compute the Kullback-Leibler divergence between two discrete prob. distributions
% kl = cross_entropy(p, q, symmetric)
%
% If symmetric = 1, we compute the symmetric version. Default: symmetric = 0;

tiny = exp(-700);
if nargin < 3, symmetric = 0; end
p = p(:);
q = q(:);
if symmetric
  kl  = (sum(p .* log((p+tiny)./(q+tiny))) + sum(q .* log((q+tiny)./(p+tiny))))/2;
else
  kl  = sum(p .* log((p+tiny)./(q+tiny)));
end                                           
