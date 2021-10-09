function [ll, p] = prob_path(prior, transmat, obsmat, qs)
% PROB_PATH Compute the prob. of a specific path (state sequence) through an HMM.
% [ll, p] = prob_path(prior, transmat, obsmat, states)
%
% ll = log prob path
% p(t) = Pr(O(t)) * Pr(Q(t) -> Q(t+1)) for 1<=t<T, p(T) = Pr(O(T))

T = size(obsmat, 2);
p = zeros(1,T);
p(1) = prior(qs(1)) * obsmat(qs(1),1);
for t=2:T
  p(t) = transmat(qs(t-1), qs(t)) * obsmat(qs(t),t);
end

ll = sum(log(p));
