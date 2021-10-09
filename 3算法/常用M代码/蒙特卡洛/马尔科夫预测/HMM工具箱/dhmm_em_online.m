function [transmat, obsmat, exp_num_trans, exp_num_emit, gamma, ll] = dhmm_em_online(...
    prior, transmat, obsmat, exp_num_trans, exp_num_emit, decay, data, ...
    act, adj_trans, adj_obs, dirichlet, filter_only)
% ONLINE_EM Adjust the parameters using a weighted combination of the old and new expected statistics
%
% [transmat, obsmat, exp_num_trans, exp_num_emit, gamma, ll] = online_em(...
%    prior, transmat, obsmat, exp_num_trans, exp_num_emit, decay, data, act, ...
%    adj_trans, adj_obs, dirichlet, filter_only)
% 
% 0 < decay < 1, with smaller values meaning the past is forgotten more quickly.
% (We need to decay the old ess, since they were based on out-of-date parameters.)
% The other params are as in learn_hmm.
% We do a single forwards-backwards pass on the provided data, initializing with the specified prior.
% (If filter_only = 1, we only do a forwards pass.)

if ~exist('act'), act = []; end
if ~exist('adj_trans'), adj_trans = 1; end
if ~exist('adj_obs'), adj_obs = 1; end
if ~exist('dirichlet'), dirichlet = 0; end
if ~exist('filter_only'), filter_only = 0; end

% E step
olikseq = multinomial_prob(data, obsmat);
if isempty(act)
  [alpha, beta, gamma, ll, xi] = fwdback(prior, transmat, olikseq, 'fwd_only', filter_only);
else
  [alpha, beta, gamma, ll, xi] = fwdback(prior, transmat, olikseq, 'fwd_only', filter_only, ...
					 'act', act);
end

% Increment ESS
[S O] = size(obsmat);
if adj_obs
  exp_num_emit = decay*exp_num_emit + dirichlet*ones(S,O);
  T = length(data);
  if T < O
    for t=1:T
      o = data(t);
      exp_num_emit(:,o) = exp_num_emit(:,o) + gamma(:,t);
    end
  else
    for o=1:O
      ndx = find(data==o);
      if ~isempty(ndx)
	exp_num_emit(:,o) = exp_num_emit(:,o) + sum(gamma(:, ndx), 2);
      end
    end
  end
end

if adj_trans & (T > 1)
  if isempty(act)
    exp_num_trans = decay*exp_num_trans + sum(xi,3);
  else
    % act(2) determines Q(2), xi(:,:,1) holds P(Q(1), Q(2))
    A = length(transmat);
    for a=1:A
      ndx = find(act(2:end)==a);
      if ~isempty(ndx)
	exp_num_trans{a} = decay*exp_num_trans{a} + sum(xi(:,:,ndx), 3);
      end
    end
  end
end


% M step

if adj_obs
  obsmat = mk_stochastic(exp_num_emit);
end
if adj_trans & (T>1)
  if isempty(act)
    transmat = mk_stochastic(exp_num_trans);
  else
    for a=1:A
      transmat{a} = mk_stochastic(exp_num_trans{a});
    end
  end
end
