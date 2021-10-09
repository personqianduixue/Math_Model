function [mu, Sigma] = mixgaussTrainObserved(obsData, hiddenData, nstates, varargin);
% mixgaussTrainObserved Max likelihood estimates of conditional Gaussian from raw data
% function [mu, Sigma] = mixgaussTrainObserved(obsData, hiddenData, nstates, ...);
%
% Input:
% obsData(:,i)
% hiddenData(i)  - this is the mixture component label for example i
% Optional arguments - same as mixgauss_Mstep
%
% Output:
% mu(:,q)
% Sigma(:,:,q) - same as mixgauss_Mstep

[D numex] = size(obsData);
Y = zeros(D, nstates);
YY = zeros(D,D,nstates);
YTY = zeros(nstates,1);
w = zeros(nstates, 1);
for q=1:nstates
  ndx = find(hiddenData==q);
  w(q) = length(ndx); % each data point has probability 1 of being in this cluster
  data = obsData(:,ndx);
  Y(:,q) = sum(data,2);
  YY(:,:,q) = data*data';
  YTY(q) = sum(diag(data'*data));
end
[mu, Sigma] = mixgauss_Mstep(w, Y, YY, YTY, varargin{:});
