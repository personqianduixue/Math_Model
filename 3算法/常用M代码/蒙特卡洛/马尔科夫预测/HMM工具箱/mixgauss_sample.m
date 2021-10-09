function [data, indices] = mixgauss_sample(mu, Sigma, mixweights, Nsamples)
%  mixgauss_sample Sample data from a mixture of Gaussians
% function [data, indices] = mixgauss_sample(mu, Sigma, mixweights, Nsamples)
%
% Model is P(X) = sum_k mixweights(k) N(X; mu(:,k), Sigma(:,:,k)) or Sigma(k) for scalar
% data(:,i) is the i'th sample from P(X)
% indices(i) is the component from which sample i was drawn

[D K] = size(mu);
data = zeros(D, Nsamples);
indices = sample_discrete(mixweights, 1, Nsamples);
for k=1:K
  if ndims(Sigma) < 3
    sig = Sigma(k);
  else
    sig = Sigma(:,:,k);
  end
  ndx = find(indices==k);
  if length(ndx) > 0
    data(:,ndx) = sample_gaussian(mu(:,k), sig, length(ndx))';
  end
end
