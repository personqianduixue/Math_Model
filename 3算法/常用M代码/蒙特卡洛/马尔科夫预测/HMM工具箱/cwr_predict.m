function  [mu, Sigma, weights, mask] = cwr_predict(cwr, X, mask_data)
% CWR_PREDICT cluster weighted regression: predict Y given X 
% function  [mu, Sigma] = cwr_predict(cwr, X)
% 
% mu(:,t) = E[Y|X(:,t)] = sum_c P(c | X(:,t)) E[Y|c, X(:,t)]
% Sigma(:,:,t) = Cov[Y|X(:,t)]
%
% [mu, Sigma, weights, mask] = cwr_predict(cwr, X, mask_data)
% mask(i) = sum_t sum_c p(mask_data(:,i) | X(:,t), c) P(c|X(:,t))
% This evaluates the predictive density on a set of points
% (This is only sensible if T=1, ie. X is a single vector)

[nx T] = size(X);
[ny nx nc] = size(cwr.weightsY);
mu = zeros(ny, T);
Sigma = zeros(ny, ny, T);

if nargout == 4
  comp_mask = 1;
  N = size(mask_data,2);
  mask = zeros(N,1);
else
  comp_mask = 0;
end

if nc==1
  if isempty(cwr.weightsY)
    mu = repmat(cwr.muY, 1, T);
    Sigma = repmat(cwr.SigmaY, [1 1 T]);
  else
    mu = repmat(cwr.muY, 1, T) + cwr.weightsY * X;
    Sigma = repmat(cwr.SigmaY, [1 1 T]);
    %for t=1:T
    %  mu(:,t) = cwr.muY + cwr.weightsY*X(:,t);
    %  Sigma(:,:,t) = cwr.SigmaY;
    %end
  end
  if comp_mask, mask = gaussian_prob(mask_data, mu, Sigma); end
  weights = [];
  return;
end


% likX(c,t) = p(x(:,t) | c)
likX = mixgauss_prob(X, cwr.muX, cwr.SigmaX);
weights = normalize(repmat(cwr.priorC, 1, T) .* likX, 1);
for t=1:T
  mut = zeros(ny, nc);
  for c=1:nc
    mut(:,c) = cwr.muY(:,c) + cwr.weightsY(:,:,c)*X(:,t);
    if comp_mask
      mask = mask + gaussian_prob(mask_data, mut(:,c), cwr.SigmaY(:,:,c)) * weights(c);
    end
  end
  %w = normalise(cwr.priorC(:)  .* likX(:,t));
  [mu(:,t), Sigma(:,:,t)] = collapse_mog(mut, cwr.SigmaY, weights(:,t));
end
