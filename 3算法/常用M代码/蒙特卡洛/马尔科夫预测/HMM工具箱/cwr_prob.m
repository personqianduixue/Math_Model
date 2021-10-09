function  [likXandY, likYgivenX, post] = cwr_prob(cwr, X, Y);
% CWR_EVAL_PDF cluster weighted regression: evaluate likelihood of Y given X 
% function  [likXandY, likYgivenX, post] = cwr_prob(cwr, X, Y);
% 
% likXandY(t) = p(x(:,t), y(:,t))
% likXgivenY(t) = p(x(:,t)| y(:,t))
% post(c,t) = p(c | x(:,t), y(:,t))

[nx N] = size(X);
nc = length(cwr.priorC);

if nc == 1
  [mu, Sigma] = cwr_predict(cwr, X);
  likY = gaussian_prob(Y, mu, Sigma);
  likXandY = likY;
  likYgivenX = likY;
  post = ones(1,N);
  return;
end


% likY(c,t) = p(y(:,t) | c)
likY = clg_prob(X, Y, cwr.muY, cwr.SigmaY, cwr.weightsY);

% likX(c,t) = p(x(:,t) | c)
[junk, likX] = mixgauss_prob(X, cwr.muX, cwr.SigmaX);
likX = squeeze(likX);

% prior(c,t) = p(c)
prior = repmat(cwr.priorC(:), 1, N);

post = likX .* likY .* prior;
likXandY = sum(post, 1);
post = post ./ repmat(likXandY, nc, 1);
%loglik = sum(log(lik));
%loglik = log(lik);

likX = sum(likX .* prior, 1);
likYgivenX = likXandY ./ likX;
