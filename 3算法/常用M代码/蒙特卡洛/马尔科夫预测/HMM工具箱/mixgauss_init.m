function [mu, Sigma, weights] = mixgauss_init(M, data, cov_type, method)
% MIXGAUSS_INIT Initial parameter estimates for a mixture of Gaussians
% function [mu, Sigma, weights] = mixgauss_init(M, data, cov_type. method)
%
% INPUTS:
% data(:,t) is the t'th example
% M = num. mixture components
% cov_type = 'full', 'diag' or 'spherical'
% method = 'rnd' (choose centers randomly from data) or 'kmeans' (needs netlab)
%
% OUTPUTS:
% mu(:,k) 
% Sigma(:,:,k) 
% weights(k)

if nargin < 4, method = 'kmeans'; end

[d T] = size(data);
data = reshape(data, d, T); % in case it is data(:, t, sequence_num)

switch method
 case 'rnd', 
  C = cov(data');
  Sigma = repmat(diag(diag(C))*0.5, [1 1 M]);
  % Initialize each mean to a random data point
  indices = randperm(T);
  mu = data(:,indices(1:M));
  weights = normalise(ones(M,1));
 case 'kmeans',
  mix = gmm(d, M, cov_type);
  options = foptions;
  max_iter = 5;
  options(1) = -1; % be quiet!
  options(14) = max_iter;
  mix = gmminit(mix, data', options);
  mu = reshape(mix.centres', [d M]);
  weights = mix.priors(:);
  for m=1:M
    switch cov_type
     case 'diag',
      Sigma(:,:,m) = diag(mix.covars(m,:));
     case 'full',
      Sigma(:,:,m) = mix.covars(:,:,m);
     case 'spherical',
      Sigma(:,:,m) = mix.covars(m) * eye(d);
    end
  end
end

