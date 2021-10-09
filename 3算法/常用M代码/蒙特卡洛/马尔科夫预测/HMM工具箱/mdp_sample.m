function state = sample_mdp(prior, trans, act)
% SAMPLE_MDP Sample a sequence of states from a Markov Decision Process.
% state = sample_mdp(prior, trans, act)
%
% Inputs:
% prior(i) = Pr(Q(1)=i)
% trans{a}(i,j) = Pr(Q(t)=j | Q(t-1)=i, A(t)=a)
% act(a) = A(t), so act(1) is ignored
%
% Output:
% state is a vector of length T=length(act)

len = length(act);
state = zeros(1,len);
state(1) = sample_discrete(prior);
for t=2:len
  state(t) = sample_discrete(trans{act(t)}(state(t-1),:));
end
