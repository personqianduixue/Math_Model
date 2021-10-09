function mixgauss = mixgauss_classifier_train(trainFeatures, trainLabels, nc, varargin)
% function mixgauss = mixgauss_classifier_train(trainFeatures, trainLabels, nclusters, varargin)
% trainFeatures(:,i) for i'th example
% trainLabels should be 0,1
% To evaluate performance on a tets set, use
% mixgauss = mixgauss_classifier_train(trainFeatures, trainLabels, nc, 'testFeatures', tf, 'testLabels', tl)

[testFeatures, testLabels, max_iter, thresh, cov_type, mu, Sigma, priorC, method, ...
 cov_prior, verbose, prune_thresh] = process_options(...
    varargin, 'testFeatures', [], 'testLabels', [], ...
     'max_iter', 10, 'thresh', 0.01, 'cov_type', 'diag', ...
    'mu', [], 'Sigma', [], 'priorC', [], 'method', 'kmeans', ...
    'cov_prior', [], 'verbose', 0, 'prune_thresh', 0);

Nclasses = 2; % max([trainLabels testLabels]) + 1;

pos = find(trainLabels == 1);
neg = find(trainLabels == 0);

if verbose, fprintf('fitting pos\n'); end
[mixgauss.pos.mu, mixgauss.pos.Sigma, mixgauss.pos.prior] = ...
    mixgauss_em(trainFeatures(:, pos), nc, varargin{:});

if verbose, fprintf('fitting neg\n'); end
[mixgauss.neg.mu, mixgauss.neg.Sigma, mixgauss.neg.prior] = ...
    mixgauss_em(trainFeatures(:, neg), nc, varargin{:});


if ~isempty(priorC)
  mixgauss.priorC = priorC;
else
  mixgauss.priorC = normalize([length(pos) length(neg)]);
end
