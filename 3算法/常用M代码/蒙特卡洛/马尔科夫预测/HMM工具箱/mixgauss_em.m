function [mu, Sigma, prior] = mixgauss_em(Y, nc, varargin)
% MIXGAUSS_EM Fit the parameters of a mixture of Gaussians using EM
% function [mu, Sigma, prior] = mixgauss_em(data, nc, varargin)
%
% data(:, t) is the t'th data point
% nc is the number of clusters

% Kevin Murphy, 13 May 2003

[max_iter, thresh, cov_type, mu, Sigma, method, ...
 cov_prior, verbose, prune_thresh] = process_options(...
    varargin, 'max_iter', 10, 'thresh', 1e-2, 'cov_type', 'full', ...
    'mu', [], 'Sigma', [],  'method', 'kmeans', ...
    'cov_prior', [], 'verbose', 0, 'prune_thresh', 0);

[ny T] = size(Y);

if nc==1
  % No latent variable, so there is a closed-form solution
  mu = mean(Y')';
  Sigma = cov(Y');
  if strcmp(cov_type, 'diag')
    Sigma = diag(diag(Sigma));
  end
  prior = 1;
  return;
end

if isempty(mu)
  [mu, Sigma, prior] = mixgauss_init(nc, Y, cov_type, method);
end

previous_loglik = -inf;
num_iter = 1;
converged = 0;

%if verbose, fprintf('starting em\n'); end

while (num_iter <= max_iter) & ~converged
  % E step
  probY = mixgauss_prob(Y, mu, Sigma, prior); % probY(q,t)
  [post, lik] = normalize(probY .* repmat(prior, 1, T), 1); % post(q,t)
  loglik = log(sum(lik));
 
  % extract expected sufficient statistics
  w = sum(post,2);  % w(c) = sum_t post(c,t)
  WYY = zeros(ny, ny, nc);  % WYY(:,:,c) = sum_t post(c,t) Y(:,t) Y(:,t)'
  WY = zeros(ny, nc);  % WY(:,c) = sum_t post(c,t) Y(:,t)
  WYTY = zeros(nc,1); % WYTY(c) = sum_t post(c,t) Y(:,t)' Y(:,t)
  for c=1:nc
    weights = repmat(post(c,:), ny, 1); % weights(:,t) = post(c,t)
    WYbig = Y .* weights; % WYbig(:,t) = post(c,t) * Y(:,t)
    WYY(:,:,c) = WYbig * Y';
    WY(:,c) = sum(WYbig, 2); 
    WYTY(c) = sum(diag(WYbig' * Y)); 
  end
  
  % M step
  prior = normalize(w);
  [mu, Sigma] = mixgauss_Mstep(w, WY, WYY, WYTY, 'cov_type', cov_type, 'cov_prior', cov_prior);
  
  if verbose, fprintf(1, 'iteration %d, loglik = %f\n', num_iter, loglik); end
  num_iter =  num_iter + 1;
  converged = em_converged(loglik, previous_loglik, thresh);
  previous_loglik = loglik;
  
end

if prune_thresh > 0
  ndx = find(prior < prune_thresh);
  mu(:,ndx) = [];
  Sigma(:,:,ndx) = [];
  prior(ndx) = [];
end
