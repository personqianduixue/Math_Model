function x = mixgauss_sample(mu, Sigma, labels)
% MIXGAUSS_SAMPLE Sample from a mixture of Gaussians given known mixture labels
% function x = mixgauss_sample(mu, Sigma, labels)

T = length(labels);
[D Q] = size(mu);
x = zeros(D,T);
for q=1:Q
  ndx = find(labels==q);
  x(:,ndx) = gaussian_sample(mu(:,q)', Sigma(:,:,q), length(ndx))';
end
