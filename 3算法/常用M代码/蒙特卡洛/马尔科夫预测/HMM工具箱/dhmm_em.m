function [LL, prior, transmat, obsmat, nrIterations] = ...
   dhmm_em(data, prior, transmat, obsmat, varargin)
% LEARN_DHMM Find the ML/MAP parameters of an HMM with discrete outputs using EM.
% [ll_trace, prior, transmat, obsmat, iterNr] = learn_dhmm(data, prior0, transmat0, obsmat0, ...)
%
% Notation: Q(t) = hidden state, Y(t) = observation
%
% INPUTS:
% data{ex} or data(ex,:) if all sequences have the same length
% prior(i)
% transmat(i,j)
% obsmat(i,o)
%
% Optional parameters may be passed as 'param_name', param_value pairs.
% Parameter names are shown below; default values in [] - if none, argument is mandatory.
%
% 'max_iter' - max number of EM iterations [10]
% 'thresh' - convergence threshold [1e-4]
% 'verbose' - if 1, print out loglik at every iteration [1]
% 'obs_prior_weight' - weight to apply to uniform dirichlet prior on observation matrix [0]
%
% To clamp some of the parameters, so learning does not change them:
% 'adj_prior' - if 0, do not change prior [1]
% 'adj_trans' - if 0, do not change transmat [1]
% 'adj_obs' - if 0, do not change obsmat [1]
%
% Modified by Herbert Jaeger so xi are not computed individually
% but only their sum (over time) as xi_summed; this is the only way how they are used
% and it saves a lot of memory.

[max_iter, thresh, verbose, obs_prior_weight, adj_prior, adj_trans, adj_obs] = ...
   process_options(varargin, 'max_iter', 10, 'thresh', 1e-4, 'verbose', 1, ...
                   'obs_prior_weight', 0, 'adj_prior', 1, 'adj_trans', 1, 'adj_obs', 1);

previous_loglik = -inf;
loglik = 0;
converged = 0;
num_iter = 1;
LL = [];

if ~iscell(data)
 data = num2cell(data, 2); % each row gets its own cell
end

while (num_iter <= max_iter) & ~converged
 % E step
 [loglik, exp_num_trans, exp_num_visits1, exp_num_emit] = ...
     compute_ess_dhmm(prior, transmat, obsmat, data, obs_prior_weight);

 % M step
 if adj_prior
   prior = normalise(exp_num_visits1);
 end
 if adj_trans & ~isempty(exp_num_trans)
   transmat = mk_stochastic(exp_num_trans);
 end
 if adj_obs
   obsmat = mk_stochastic(exp_num_emit);
 end

 if verbose, fprintf(1, 'iteration %d, loglik = %f\n', num_iter, loglik); end
 num_iter =  num_iter + 1;
 converged = em_converged(loglik, previous_loglik, thresh);
 previous_loglik = loglik;
 LL = [LL loglik];
end
nrIterations = num_iter - 1;

%%%%%%%%%%%%%%%%%%%%%%%

function [loglik, exp_num_trans, exp_num_visits1, exp_num_emit, exp_num_visitsT] = ...
   compute_ess_dhmm(startprob, transmat, obsmat, data, dirichlet)
% COMPUTE_ESS_DHMM Compute the Expected Sufficient Statistics for an HMM with discrete outputs
% function [loglik, exp_num_trans, exp_num_visits1, exp_num_emit, exp_num_visitsT] = ...
%    compute_ess_dhmm(startprob, transmat, obsmat, data, dirichlet)
%
% INPUTS:
% startprob(i)
% transmat(i,j)
% obsmat(i,o)
% data{seq}(t)
% dirichlet - weighting term for uniform dirichlet prior on expected emissions
%
% OUTPUTS:
% exp_num_trans(i,j) = sum_l sum_{t=2}^T Pr(X(t-1) = i, X(t) = j| Obs(l))
% exp_num_visits1(i) = sum_l Pr(X(1)=i | Obs(l))
% exp_num_visitsT(i) = sum_l Pr(X(T)=i | Obs(l))
% exp_num_emit(i,o) = sum_l sum_{t=1}^T Pr(X(t) = i, O(t)=o| Obs(l))
% where Obs(l) = O_1 .. O_T for sequence l.

numex = length(data);
[S O] = size(obsmat);
exp_num_trans = zeros(S,S);
exp_num_visits1 = zeros(S,1);
exp_num_visitsT = zeros(S,1);
exp_num_emit = dirichlet*ones(S,O);
loglik = 0;

for ex=1:numex
 obs = data{ex};
 T = length(obs);
 %obslik = eval_pdf_cond_multinomial(obs, obsmat);
 obslik = multinomial_prob(obs, obsmat);
 [alpha, beta, gamma, current_ll, xi_summed] = fwdback(startprob, transmat, obslik);

 loglik = loglik +  current_ll;
 exp_num_trans = exp_num_trans + xi_summed;
 exp_num_visits1 = exp_num_visits1 + gamma(:,1);
 exp_num_visitsT = exp_num_visitsT + gamma(:,T);
 % loop over whichever is shorter
 if T < O
   for t=1:T
     o = obs(t);
     exp_num_emit(:,o) = exp_num_emit(:,o) + gamma(:,t);
   end
 else
   for o=1:O
     ndx = find(obs==o);
     if ~isempty(ndx)
       exp_num_emit(:,o) = exp_num_emit(:,o) + sum(gamma(:, ndx), 2);
     end
   end
 end
end
