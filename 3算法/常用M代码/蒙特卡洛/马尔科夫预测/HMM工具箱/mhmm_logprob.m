function [loglik, errors] = mhmm_logprob(data, prior, transmat, mu, Sigma, mixmat)
% LOG_LIK_MHMM Compute the log-likelihood of a dataset using a (mixture of) Gaussians HMM
% [loglik, errors] = log_lik_mhmm(data, prior, transmat, mu, sigma, mixmat)
%
% data{m}(:,t) or data(:,t,m) if all cases have same length
% errors  is a list of the cases which received a loglik of -infinity
%
% Set mixmat to ones(Q,1) or omit it if there is only 1 mixture component

Q = length(prior);
if size(mixmat,1) ~= Q % trap old syntax
  error('mixmat should be QxM')
end
if nargin < 6, mixmat = ones(Q,1); end

if ~iscell(data)
  data = num2cell(data, [1 2]); % each elt of the 3rd dim gets its own cell
end
ncases = length(data);

loglik = 0;
errors = [];
for m=1:ncases
  obslik = mixgauss_prob(data{m}, mu, Sigma, mixmat);
  [alpha, beta, gamma, ll] = fwdback(prior, transmat, obslik, 'fwd_only', 1);
  if ll==-inf
    errors = [errors m];
  end
  loglik = loglik + ll;
end
