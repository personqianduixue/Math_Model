function [obs, hidden] = mhmm_sample(T, numex, initial_prob, transmat, mu, Sigma, mixmat)
% SAMPLE_MHMM Generate random sequences from an HMM with (mixtures of) Gaussian output.
% [obs, hidden] = sample_mhmm(T, numex, initial_prob, transmat, mu, Sigma, mixmat)
%
% INPUTS:
% T - length of each sequence
% numex - num. sequences
% init_state_prob(i) = Pr(Q(1) = i)
% transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
% mu(:,j,k) = mean of Y(t) given Q(t)=j, M(t)=k
% Sigma(:,:,j,k) = cov. of Y(t) given Q(t)=j, M(t)=k
% mixmat(j,k) = Pr(M(t)=k | Q(t)=j) : set to ones(Q,1) or omit if single mixture
%
% OUTPUT:
% obs(:,t,l) = observation vector at time t for sequence l
% hidden(t,l) = the hidden state at time t for sequence l

Q = length(initial_prob);
if nargin < 7, mixmat = ones(Q,1); end
O = size(mu,1);
hidden = zeros(T, numex);
obs = zeros(O, T, numex);

hidden = mc_sample(initial_prob, transmat, T, numex)';
for i=1:numex
  for t=1:T
    q = hidden(t,i);
    m = sample_discrete(mixmat(q,:), 1, 1);
    obs(:,t,i) =  gaussian_sample(mu(:,q,m), Sigma(:,:,q,m), 1);
  end
end
