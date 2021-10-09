function logp = enumerate_HMM_loglik(prior, transmat, obsmat)
% ENUMERATE_HMM_LOGLIK Compute the log likelihood of a sequence by exhaustive (O(Q^T)) enumeration.
% logp = enumerate_HMM_loglik(prior, transmat, obsmat)
%
% Inputs:
% prior(i) = Pr(Q(1) = i)
% transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
% obsmat(i,t) = Pr(y(t) | Q(t)=i)

Q = length(prior);
T = size(obsmat, 2);
sizes = repmat(Q, 1, T);

psum = 0;
for i=1:Q^T
  qs = ind2subv(sizes, i); % make the state sequence 
  psum = psum + prob_path(prior, transmat, obsmat, qs);
end
logp = log(psum)

 
