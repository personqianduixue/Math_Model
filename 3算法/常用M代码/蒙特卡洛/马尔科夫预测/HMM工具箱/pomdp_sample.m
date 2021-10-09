function [obs, hidden] = pomdp_sample(initial_prob, transmat, obsmat, act)
% SAMPLE_POMDP Generate a random sequence from a Partially Observed Markov Decision Process.
% [obs, hidden] = sample_pomdp(prior, transmat, obsmat, act)
%
% Inputs:
% prior(i) = Pr(Q(1)=i)
% transmat{a}(i,j) = Pr(Q(t)=j | Q(t-1)=i, A(t)=a)
% obsmat(i,k) = Pr(Y(t)=k | Q(t)=i)
% act(a) = A(t), so act(1) is ignored
%
% Output:
% obs and hidden are vectors of length T=length(act)


len = length(act);
hidden = mdp_sample(initial_prob, transmat, act);
obs = zeros(1, len);
for t=1:len
  obs(t) = sample_discrete(obsmat(hidden(t),:));
end
