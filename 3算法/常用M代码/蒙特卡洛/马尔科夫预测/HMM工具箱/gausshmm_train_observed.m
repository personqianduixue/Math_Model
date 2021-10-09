function [initState, transmat, mu, Sigma] = gausshmm_train_observed(obsData, hiddenData, ...
						  nstates, varargin)
% GAUSSHMM_TRAIN_OBSERVED  Estimate params of HMM with Gaussian output from fully observed sequences
% [initState, transmat, mu, Sigma] = gausshmm_train_observed(obsData, hiddenData, nstates,...)
%
% INPUT
% If all sequences have the same length
% obsData(:,t,ex) 
% hiddenData(ex,t)  - must be ROW vector if only one sequence
% If sequences have different lengths, we use cell arrays
% obsData{ex}(:,t) 
% hiddenData{ex}(t)
%
% Optional argumnets
% dirichletPriorWeight - for smoothing transition matrix counts
%
% Optional parameters from mixgauss_Mstep:
% 'cov_type' - 'full', 'diag' or 'spherical' ['full']
% 'tied_cov' - 1 (Sigma) or 0 (Sigma_i) [0]
% 'clamped_cov' - pass in clamped value, or [] if unclamped [ [] ]
% 'clamped_mean' - pass in clamped value, or [] if unclamped [ [] ]
% 'cov_prior' - Lambda_i, added to YY(:,:,i) [0.01*eye(d,d,Q)]
%
% Output
% mu(:,q)
% Sigma(:,:,q) 

[dirichletPriorWeight, other] = process_options(...
    varargin, 'dirichletPriorWeight', 0);

[transmat, initState] = transmat_train_observed(hiddenData, nstates, ...
						'dirichletPriorWeight', dirichletPriorWeight);

% convert to obsData(:,t*nex)
if ~iscell(obsData)
  [D T Nex] = size(obsData);
  obsData = reshape(obsData, D, T*Nex);
else
  obsData = cat(2, obsData{:});
  hiddenData = cat(2,hiddenData{:});
end
[mu, Sigma] = condgaussTrainObserved(obsData, hiddenData(:), nstates, varargin{:});

 
