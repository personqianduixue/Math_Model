function [mu, Sigma, B] = clg_Mstep(w, Y, YY, YTY, X, XX, XY, varargin)
% MSTEP_CLG Compute ML/MAP estimates for a conditional linear Gaussian
% [mu, Sigma, B] = Mstep_clg(w, Y, YY, YTY, X, XX, XY, varargin)
%
% We fit P(Y|X,Q=i) = N(Y; B_i X + mu_i, Sigma_i) 
% and w(i,t) = p(M(t)=i|y(t)) = posterior responsibility
% See www.ai.mit.edu/~murphyk/Papers/learncg.pdf.
%
% See process_options for how to specify the input arguments.
%
% INPUTS:
% w(i) = sum_t w(i,t) = responsibilities for each mixture component
%  If there is only one mixture component (i.e., Q does not exist),
%  then w(i) = N = nsamples,  and 
%  all references to i can be replaced by 1.
% Y(:,i) = sum_t w(i,t) y(:,t) = weighted observations
% YY(:,:,i) = sum_t w(i,t) y(:,t) y(:,t)' = weighted outer product
% YTY(i) = sum_t w(i,t) y(:,t)' y(:,t) = weighted inner product
%   You only need to pass in YTY if Sigma is to be estimated as spherical.
%
% In the regression context, we must also pass in the following
% X(:,i) = sum_t w(i,t) x(:,t) = weighted inputs
% XX(:,:,i) = sum_t w(i,t) x(:,t) x(:,t)' = weighted outer product
% XY(i) = sum_t w(i,t) x(:,t) y(:,t)' = weighted outer product
%
% Optional inputs (default values in [])
%
% 'cov_type' - 'full', 'diag' or 'spherical' ['full']
% 'tied_cov' - 1 (Sigma) or 0 (Sigma_i) [0]
% 'clamped_cov' - pass in clamped value, or [] if unclamped [ [] ]
% 'clamped_mean' - pass in clamped value, or [] if unclamped [ [] ]
% 'clamped_weights' - pass in clamped value, or [] if unclamped [ [] ]
% 'cov_prior' - added to Sigma(:,:,i) to ensure psd [0.01*eye(d,d,Q)]
%
% If cov is tied, Sigma has size d*d.
% But diagonal and spherical covariances are represented in full size.

[cov_type, tied_cov, ...
 clamped_cov, clamped_mean, clamped_weights,  cov_prior, ...
 xs, ys, post] = ...
    process_options(varargin, ...
		    'cov_type', 'full', 'tied_cov', 0,  'clamped_cov', [], 'clamped_mean', [], ...
		    'clamped_weights', [], 'cov_prior', [], ...
		    'xs', [], 'ys', [], 'post', []);

[Ysz Q] = size(Y);

if isempty(X) % no regression
  %B = [];
  B2 = zeros(Ysz, 1, Q);
  for i=1:Q
    B(:,:,i) = B2(:,1:0,i); % make an empty array of size Ysz x 0 x Q
  end
  [mu, Sigma] = mixgauss_Mstep(w, Y, YY, YTY, varargin{:});
  return;
end


N = sum(w);
if isempty(cov_prior)
  cov_prior = 0.01*repmat(eye(Ysz,Ysz), [1 1 Q]);
end
%YY = YY + cov_prior; % regularize the scatter matrix

% Set any zero weights to one before dividing
% This is valid because w(i)=0 => Y(:,i)=0, etc
w = w + (w==0);

Xsz = size(X,1);
% Append 1 to X to get Z
ZZ = zeros(Xsz+1, Xsz+1, Q);
ZY = zeros(Xsz+1, Ysz, Q);
for i=1:Q
  ZZ(:,:,i) = [XX(:,:,i)  X(:,i);
	       X(:,i)'    w(i)];
  ZY(:,:,i) = [XY(:,:,i);
	       Y(:,i)'];
end


%%% Estimate mean and regression 

if ~isempty(clamped_weights) & ~isempty(clamped_mean)
  B = clamped_weights;
  mu = clamped_mean;
end
if ~isempty(clamped_weights) & isempty(clamped_mean)
  B = clamped_weights;
  % eqn 5
  mu = zeros(Ysz, Q);
  for i=1:Q
    mu(:,i) = (Y(:,i) - B(:,:,i)*X(:,i)) / w(i);
  end
end
if isempty(clamped_weights) & ~isempty(clamped_mean)
  mu = clamped_mean;
  % eqn 3
  B = zeros(Ysz, Xsz, Q);
  for i=1:Q
    tmp = XY(:,:,i)' - mu(:,i)*X(:,i)';
    %B(:,:,i) = tmp * inv(XX(:,:,i));
    B(:,:,i) = (XX(:,:,i) \ tmp')';
  end
end
if isempty(clamped_weights) & isempty(clamped_mean)
  mu = zeros(Ysz, Q);
  B = zeros(Ysz, Xsz, Q);
  % Nothing is clamped, so we must estimate B and mu jointly
  for i=1:Q
    % eqn 9
    if rcond(ZZ(:,:,i)) < 1e-10
      sprintf('clg_Mstep warning: ZZ(:,:,%d) is ill-conditioned', i);
      % probably because there are too few cases for a high-dimensional input
      ZZ(:,:,i) = ZZ(:,:,i) + 1e-5*eye(Xsz+1);
    end
    %A = ZY(:,:,i)' * inv(ZZ(:,:,i));
    A = (ZZ(:,:,i) \ ZY(:,:,i))';
    B(:,:,i) = A(:, 1:Xsz);
    mu(:,i) = A(:, Xsz+1);
  end
end

if ~isempty(clamped_cov)
  Sigma = clamped_cov;
  return;
end


%%% Estimate covariance

% Spherical
if cov_type(1)=='s'
  if ~tied_cov
    Sigma = zeros(Ysz, Ysz, Q);
    for i=1:Q
      % eqn 16
      A = [B(:,:,i) mu(:,i)];
      %s = trace(YTY(i) + A'*A*ZZ(:,:,i) - 2*A*ZY(:,:,i)) / (Ysz*w(i)); % wrong!
      s = (YTY(i) + trace(A'*A*ZZ(:,:,i)) - trace(2*A*ZY(:,:,i))) / (Ysz*w(i));
      Sigma(:,:,i) = s*eye(Ysz,Ysz);

      %%%%%%%%%%%%%%%%%%% debug
      if ~isempty(xs)
	[nx T] = size(xs);
	zs = [xs; ones(1,T)];
	yty = 0;
	zAAz = 0;
	yAz = 0;
	for t=1:T
	  yty = yty + ys(:,t)'*ys(:,t) * post(i,t);
	  zAAz = zAAz + zs(:,t)'*A'*A*zs(:,t)*post(i,t);
	  yAz = yAz + ys(:,t)'*A*zs(:,t)*post(i,t);
	end
	assert(approxeq(yty, YTY(i)))
	assert(approxeq(zAAz, trace(A'*A*ZZ(:,:,i))))
	assert(approxeq(yAz, trace(A*ZY(:,:,i))))
	s2 = (yty + zAAz - 2*yAz) / (Ysz*w(i));
	assert(approxeq(s,s2))
      end
      %%%%%%%%%%%%%%% end debug
      
    end
  else
    S = 0;
    for i=1:Q
      % eqn 18
      A = [B(:,:,i) mu(:,i)];
      S = S + trace(YTY(i) + A'*A*ZZ(:,:,i) - 2*A*ZY(:,:,i));
    end
    Sigma = repmat(S / (N*Ysz), [1 1 Q]);
  end
else % Full/diagonal
  if ~tied_cov
    Sigma = zeros(Ysz, Ysz, Q);
    for i=1:Q
      A = [B(:,:,i) mu(:,i)];
      % eqn 10
      SS = (YY(:,:,i) - ZY(:,:,i)'*A' - A*ZY(:,:,i) + A*ZZ(:,:,i)*A') / w(i);
      if cov_type(1)=='d'
	Sigma(:,:,i) = diag(diag(SS));
      else
	Sigma(:,:,i) = SS;
      end
    end
  else % tied
    SS = zeros(Ysz, Ysz);
    for i=1:Q
      A = [B(:,:,i) mu(:,i)];
      % eqn 13
      SS = SS + (YY(:,:,i) - ZY(:,:,i)'*A' - A*ZY(:,:,i) + A*ZZ(:,:,i)*A');
    end
    SS = SS / N;
    if cov_type(1)=='d'
      Sigma = diag(diag(SS));
    else
      Sigma = SS;
    end
    Sigma = repmat(Sigma, [1 1 Q]);
  end
end

Sigma = Sigma + cov_prior;
  
