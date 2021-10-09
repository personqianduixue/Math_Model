function [pc_vec]=pca_kpm(features,N, method);
% PCA_KPM Compute top N principal components using eigs or svd.
% [pc_vec]=pca_kpm(features,N) 
%
% features(:,i) is the i'th example - each COLUMN is an observation
% pc_vec(:,j) is the j'th basis function onto which you should project the data
% using pc_vec' * features

[d ncases] = size(features);
fm=features-repmat(mean(features,2), 1, ncases);


if method==1 % d*d < d*ncases
  fprintf('pca_kpm eigs\n');
  options.disp = 0;
  C = cov(fm'); % d x d matrix
  [pc_vec, evals] = eigs(C, N, 'LM', options);
else 
  % [U,D,V] = SVD(fm), U(:,i)=evec of fm fm', V(:,i) = evec of fm' fm
  fprintf('pca_kpm svds\n');
  [U,D,V] = svds(fm', N);
  pc_vec = V;
end

