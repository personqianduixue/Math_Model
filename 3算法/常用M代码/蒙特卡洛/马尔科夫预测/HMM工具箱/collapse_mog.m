function [new_mu, new_Sigma, new_Sigma2] = collapse_mog(mu, Sigma, coefs)
% COLLAPSE_MOG Collapse a mixture of Gaussians to a single Gaussian by moment matching
% [new_mu, new_Sigma] = collapse_mog(mu, Sigma, coefs)
%
% coefs(i) - weight of i'th mixture component
% mu(:,i), Sigma(:,:,i) - params of i'th mixture component

% S = sum_c w_c (S_c + m_c m_c' + m m' - 2 m_c m') 
%   = sum_c w_c (S_c + m_c m_c') + m m' - 2 (sum_c m_c) m'
%   = sum_c w_c (S_c + m_c m_c') - m m'

new_mu = sum(mu * diag(coefs), 2); % weighted sum of columns

n = length(new_mu);
new_Sigma = zeros(n,n);
new_Sigma2 = zeros(n,n);
for j=1:length(coefs)
  m = mu(:,j) - new_mu;
  new_Sigma = new_Sigma + coefs(j) * (Sigma(:,:,j) + m*m');
  new_Sigma2 = new_Sigma2 + coefs(j) * (Sigma(:,:,j) + mu(:,j)*mu(:,j)');
end
%assert(approxeq(new_Sigma, new_Sigma2 - new_mu*new_mu'))
