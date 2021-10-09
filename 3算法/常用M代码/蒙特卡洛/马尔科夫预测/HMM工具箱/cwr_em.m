function cwr  = cwr_em(X, Y, nc, varargin)
% CWR_LEARN Fit the parameters of a cluster weighted regression model using EM
% function cwr  = cwr_learn(X, Y, ...)
%
% X(:, t) is the t'th input example
% Y(:, t) is the t'th output example
% nc is the number of clusters
%
% Kevin Murphy, May 2003

[max_iter, thresh, cov_typeX, cov_typeY, clamp_weights, ...
 muX, muY, SigmaX, SigmaY, weightsY, priorC, create_init_params, ...
cov_priorX, cov_priorY, verbose, regress, clamp_covX, clamp_covY] = process_options(...
    varargin, 'max_iter', 10, 'thresh', 1e-2, 'cov_typeX', 'full', ...
     'cov_typeY', 'full', 'clamp_weights', 0, ...
     'muX', [], 'muY', [], 'SigmaX', [], 'SigmaY', [], 'weightsY', [], 'priorC', [], ...
     'create_init_params', 1, 'cov_priorX', [], 'cov_priorY', [], 'verbose', 0, ...
    'regress', 1, 'clamp_covX', 0, 'clamp_covY', 0);
     
[nx N] = size(X);
[ny N2] = size(Y);
if N ~= N2
  error(sprintf('nsamples X (%d) ~= nsamples Y (%d)', N, N2));
end
%if N < nx 
%  fprintf('cwr_em warning: dim X (%d) > nsamples X (%d)\n', nx, N);
%end
if (N < nx) & regress
  fprintf('cwr_em warning: dim X = %d, nsamples X = %d\n', nx, N);
end
if (N < ny) 
  fprintf('cwr_em warning: dim Y = %d, nsamples Y = %d\n', ny, N);
end
if (nc > N) 
  error(sprintf('cwr_em: more centers (%d) than data', nc))
end

if nc==1
  % No latent variable, so there is a closed-form solution
  w = 1/N;
  WYbig = Y*w;
  WYY = WYbig * Y'; 
  WY = sum(WYbig, 2);
  WYTY = sum(diag(WYbig' * Y));
  cwr.priorC = 1;
  cwr.SigmaX = [];
  if ~regress
    % This is just fitting an unconditional Gaussian
    cwr.weightsY = [];
    [cwr.muY, cwr.SigmaY] = ...
	mixgauss_Mstep(1, WY, WYY, WYTY, ...
		       'cov_type', cov_typeY, 'cov_prior', cov_priorY);
    % There is a much easier way...
    assert(approxeq(cwr.muY, mean(Y')))
    assert(approxeq(cwr.SigmaY, cov(Y') + 0.01*eye(ny)))
  else
    % This is just linear regression
    WXbig = X*w;
    WXX = WXbig * X';
   WX = sum(WXbig, 2);
    WXTX = sum(diag(WXbig' * X));
    WXY = WXbig * Y';
    [cwr.muY, cwr.SigmaY, cwr.weightsY] = ...
	clg_Mstep(1, WY, WYY, WYTY, WX, WXX, WXY, ...
		  'cov_type', cov_typeY, 'cov_prior', cov_priorY);
  end
  if clamp_covY, cwr.SigmaY = SigmaY; end
  if clamp_weights,  cwr.weightsY = weightsY; end
  return;
end


if create_init_params
  [cwr.muX, cwr.SigmaX] = mixgauss_init(nc, X, cov_typeX);
  [cwr.muY, cwr.SigmaY] = mixgauss_init(nc, Y, cov_typeY);
  cwr.weightsY = zeros(ny, nx, nc);
  cwr.priorC = normalize(ones(nc,1));
else
  cwr.muX = muX;  cwr.muY = muY; cwr.SigmaX = SigmaX; cwr.SigmaY = SigmaY;
  cwr.weightsY = weightsY; cwr.priorC = priorC;
end


if clamp_covY, cwr.SigmaY = SigmaY; end
if clamp_covX,  cwr.SigmaX = SigmaX; end
if clamp_weights,  cwr.weightsY = weightsY; end

previous_loglik = -inf;
num_iter = 1;
converged = 0;

while (num_iter <= max_iter) & ~converged

  % E step
  
  [likXandY, likYgivenX, post] = cwr_prob(cwr, X, Y);
  loglik = sum(log(likXandY));
  % extract expected sufficient statistics
  w = sum(post,2);  % post(c,t)
  WYY = zeros(ny, ny, nc);
  WY = zeros(ny, nc);
  WYTY = zeros(nc,1);
  
  WXX = zeros(nx, nx, nc);
  WX = zeros(nx, nc);
  WXTX = zeros(nc, 1);
  WXY = zeros(nx,ny,nc);
  %WYY = repmat(reshape(w, [1 1 nc]), [ny ny 1]) .*  repmat(Y*Y', [1 1 nc]);
  for c=1:nc
    weights = repmat(post(c,:), ny, 1);
    WYbig = Y .* weights;
    WYY(:,:,c) = WYbig * Y'; 
    WY(:,c) = sum(WYbig, 2);
    WYTY(c) = sum(diag(WYbig' * Y));

    weights = repmat(post(c,:), nx, 1); % weights(nx, nsamples)
    WXbig = X .* weights;
    WXX(:,:,c) = WXbig * X';
    WX(:,c) = sum(WXbig, 2);
    WXTX(c) = sum(diag(WXbig' * X));
    WXY(:,:,c) = WXbig * Y';
  end

  % M step
  % Q -> X is called Q->Y in Mstep_clg
  [cwr.muX, cwr.SigmaX] = mixgauss_Mstep(w, WX, WXX, WXTX, ...
			    'cov_type', cov_typeX, 'cov_prior', cov_priorX);
  for c=1:nc
    assert(is_psd(cwr.SigmaX(:,:,c)))
  end
  
  if clamp_weights % affects estimate of mu and Sigma
    W = cwr.weightsY;
  else
    W = [];
  end
  [cwr.muY, cwr.SigmaY, cwr.weightsY] = ...
      clg_Mstep(w, WY, WYY, WYTY, WX, WXX, WXY, ...
		'cov_type', cov_typeY, 'clamped_weights', W, ...
		'cov_prior', cov_priorY);
  %'xs', X, 'ys', Y, 'post', post); % debug
  %a = linspace(min(Y(2,:)), max(Y(2,:)), nc+2);
  %cwr.muY(2,:) = a(2:end-1);

  cwr.priorC = normalize(w);

  for c=1:nc
    assert(is_psd(cwr.SigmaY(:,:,c)))
  end

  if clamp_covY, cwr.SigmaY = SigmaY; end
  if clamp_covX,  cwr.SigmaX = SigmaX; end
  if clamp_weights,  cwr.weightsY = weightsY; end

  if verbose, fprintf(1, 'iteration %d, loglik = %f\n', num_iter, loglik); end
  num_iter =  num_iter + 1;
  converged = em_converged(loglik, previous_loglik, thresh);
  previous_loglik = loglik;
  
end

