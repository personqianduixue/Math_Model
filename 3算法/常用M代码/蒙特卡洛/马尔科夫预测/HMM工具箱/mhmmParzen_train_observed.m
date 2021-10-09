function [initState, transmat, mu, Nproto, pick] = mhmmParzen_train_observed(obsData, hiddenData, ...
						  nstates, maxNproto, varargin)
% mhmmParzentrain_observed  with mixture of Gaussian outputs from fully observed sequences
% function [initState, transmat, mu, Nproto] = mhmm_train_observed_parzen(obsData, hiddenData, ...
%						  nstates, maxNproto)
%
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
% mkSymmetric
%
% Output
% mu(:,q)
% Nproto(q) is the number of prototypes (mixture components) chosen for state q

[transmat, initState] = transmat_train_observed(...
    hiddenData, nstates, varargin{:});

% convert to obsData(:,t*nex)
if ~iscell(obsData)
  [D T Nex] = size(obsData);
  obsData = reshape(obsData, D, T*Nex);
else
  obsData = cat(2, obsData{:});
  hiddenData = cat(2, hiddenData{:});
end
[mu, Nproto, pick] = parzen_fit_select_unif(obsData, hiddenData(:), maxNproto);

 
