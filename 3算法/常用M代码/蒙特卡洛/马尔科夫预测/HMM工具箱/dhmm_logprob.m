function [loglik, errors] = dhmm_logprob(data, prior, transmat, obsmat)
% LOG_LIK_DHMM Compute the log-likelihood of a dataset using a discrete HMM
% [loglik, errors] = log_lik_dhmm(data, prior, transmat, obsmat)
%
% data{m} or data(m,:) is the m'th sequence
% errors  is a list of the cases which received a loglik of -infinity

if ~iscell(data)
  data = num2cell(data, 2);
end
ncases = length(data);

loglik = 0;
errors = [];
for m=1:ncases
  obslik = multinomial_prob(data{m}, obsmat);
  [alpha, beta, gamma, ll] = fwdback(prior, transmat, obslik, 'fwd_only', 1);
  if ll==-inf
    errors = [errors m];
  end
  loglik = loglik + ll;
end
