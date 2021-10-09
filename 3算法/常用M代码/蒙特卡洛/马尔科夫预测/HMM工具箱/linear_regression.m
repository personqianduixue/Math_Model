function [muY, SigmaY, weightsY]  = linear_regression(X, Y, varargin)
% LINEAR_REGRESSION Fit params for P(Y|X) = N(Y;  W X + mu, Sigma) 
%
% X(:, t) is the t'th input example
% Y(:, t) is the t'th output example
%
% Kevin Murphy, August 2003
%
% This is a special case of cwr_em with 1 cluster.
% You can also think of it as a front end to clg_Mstep.

[cov_typeY, clamp_weights,  muY, SigmaY, weightsY,...
 cov_priorY,  regress, clamp_covY] = process_options(...
    varargin, ...
     'cov_typeY', 'full', 'clamp_weights', 0, ...
     'muY', [], 'SigmaY', [], 'weightsY', [], ...
     'cov_priorY', [], 'regress', 1,  'clamp_covY', 0);
     
[nx N] = size(X);
[ny N2] = size(Y);
if N ~= N2
  error(sprintf('nsamples X (%d) ~= nsamples Y (%d)', N, N2));
end

w = 1/N;
WYbig = Y*w;
WYY = WYbig * Y'; 
WY = sum(WYbig, 2);
WYTY = sum(diag(WYbig' * Y));
if ~regress
  % This is just fitting an unconditional Gaussian
  weightsY = [];
  [muY, SigmaY] = ...
      mixgauss_Mstep(1, WY, WYY, WYTY, ...
		     'cov_type', cov_typeY, 'cov_prior', cov_priorY);
  % There is a much easier way...
  assert(approxeq(muY, mean(Y')))
  assert(approxeq(SigmaY, cov(Y') + 0.01*eye(ny)))
else
  % This is just linear regression
  WXbig = X*w;
  WXX = WXbig * X';
  WX = sum(WXbig, 2);
  WXTX = sum(diag(WXbig' * X));
  WXY = WXbig * Y';
  [muY, SigmaY, weightsY] = ...
      clg_Mstep(1, WY, WYY, WYTY, WX, WXX, WXY, ...
		'cov_type', cov_typeY, 'cov_prior', cov_priorY);
end
if clamp_covY, SigmaY = SigmaY; end
if clamp_weights,  weightsY = weightsY; end

if nx==1 & ny==1 & regress
  P = polyfit(X,Y); % Y = P(1) X^1 + P(2) X^0 = ax + b
  assert(approxeq(muY, P(2)))
  assert(approxeq(weightsY, P(1)))
end

%%%%%%%% Test
if 0 
  c1 = randn(2,100);   c2 = randn(2,100);
  y = c2(1,:); X = [ones(size(c1,2),1) c1'];
  b = regress(y(:), X); % stats toolbox
  [m,s,w] = linear_regression(c1, y);
  assert(approxeq(b(1),m))
  assert(approxeq(b(2), w(1)))
  assert(approxeq(b(3), w(2)))
end
