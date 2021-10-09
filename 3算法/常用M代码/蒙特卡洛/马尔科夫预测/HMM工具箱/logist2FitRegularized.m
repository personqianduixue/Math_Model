function [net, niter] = logist2FitRegularized(labels, features, maxIter)

if nargin < 3, maxIter = 100; end

[D  N] = size(features);
weightPrior = 0.5;
net = glm(D, 1, 'logistic', weightPrior);
options = foptions;
options(14) = maxIter;
[net, options] = glmtrain(net, options, features', labels(:));
niter = options(14);
%w = logist2Fit(labelsPatches(jValidPatches), features(:, jValidPatches));

