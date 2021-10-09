function [B, B2] = mixgauss_prob(data, mu, Sigma, mixmat, unit_norm)
% EVAL_PDF_COND_MOG Evaluate the pdf of a conditional mixture of Gaussians
% function [B, B2] = eval_pdf_cond_mog(data, mu, Sigma, mixmat, unit_norm)
%
% Notation: Y is observation, M is mixture component, and both may be conditioned on Q.
% If Q does not exist, ignore references to Q=j below.
% Alternatively, you may ignore M if this is a conditional Gaussian.
%
% INPUTS:
% data(:,t) = t'th observation vector 
%
% mu(:,k) = E[Y(t) | M(t)=k] 
% or mu(:,j,k) = E[Y(t) | Q(t)=j, M(t)=k]
%
% Sigma(:,:,j,k) = Cov[Y(t) | Q(t)=j, M(t)=k]
% or there are various faster, special cases:
%   Sigma() - scalar, spherical covariance independent of M,Q.
%   Sigma(:,:) diag or full, tied params independent of M,Q. 
%   Sigma(:,:,j) tied params independent of M. 
%
% mixmat(k) = Pr(M(t)=k) = prior
% or mixmat(j,k) = Pr(M(t)=k | Q(t)=j) 
% Not needed if M is not defined.
%
% unit_norm - optional; if 1, means data(:,i) AND mu(:,i) each have unit norm (slightly faster)
%
% OUTPUT:
% B(t) = Pr(y(t)) 
% or
% B(i,t) = Pr(y(t) | Q(t)=i) 
% B2(i,k,t) = Pr(y(t) | Q(t)=i, M(t)=k) 
%
% If the number of mixture components differs depending on Q, just set the trailing
% entries of mixmat to 0, e.g., 2 components if Q=1, 3 components if Q=2,
% then set mixmat(1,3)=0. In this case, B2(1,3,:)=1.0.




if isvector(mu) & size(mu,2)==1
  d = length(mu);
  Q = 1; M = 1;
elseif ndims(mu)==2
  [d Q] = size(mu);
  M = 1;
else
  [d Q M] = size(mu);
end
[d T] = size(data);

if nargin < 4, mixmat = ones(Q,1); end
if nargin < 5, unit_norm = 0; end

%B2 = zeros(Q,M,T); % ATB: not needed allways
%B = zeros(Q,T);

if isscalar(Sigma)
  mu = reshape(mu, [d Q*M]);
  if unit_norm % (p-q)'(p-q) = p'p + q'q - 2p'q = n+m -2p'q since p(:,i)'p(:,i)=1
    %avoid an expensive repmat
    disp('unit norm')
    %tic; D = 2 -2*(data'*mu)'; toc 
    D = 2 - 2*(mu'*data);
    tic; D2 = sqdist(data, mu)'; toc
    assert(approxeq(D,D2)) 
  else
    D = sqdist(data, mu)';
  end
  clear mu data % ATB: clear big old data
  % D(qm,t) = sq dist between data(:,t) and mu(:,qm)
  logB2 = -(d/2)*log(2*pi*Sigma) - (1/(2*Sigma))*D; % det(sigma*I) = sigma^d
  B2 = reshape(exp(logB2), [Q M T]);
  clear logB2 % ATB: clear big old data
  
elseif ndims(Sigma)==2 % tied full
  mu = reshape(mu, [d Q*M]);
  D = sqdist(data, mu, inv(Sigma))';
  % D(qm,t) = sq dist between data(:,t) and mu(:,qm)
  logB2 = -(d/2)*log(2*pi) - 0.5*logdet(Sigma) - 0.5*D;
  %denom = sqrt(det(2*pi*Sigma));
  %numer = exp(-0.5 * D);
  %B2 = numer/denom;
  B2 = reshape(exp(logB2), [Q M T]);
  
elseif ndims(Sigma)==3 % tied across M
  B2 = zeros(Q,M,T);
  for j=1:Q
    % D(m,t) = sq dist between data(:,t) and mu(:,j,m)
    if isposdef(Sigma(:,:,j))
      D = sqdist(data, permute(mu(:,j,:), [1 3 2]), inv(Sigma(:,:,j)))';
      logB2 = -(d/2)*log(2*pi) - 0.5*logdet(Sigma(:,:,j)) - 0.5*D;
      B2(j,:,:) = exp(logB2);
    else
      error(sprintf('mixgauss_prob: Sigma(:,:,q=%d) not psd\n', j));
    end
  end
  
else % general case
  B2 = zeros(Q,M,T);
  for j=1:Q
    for k=1:M
      %if mixmat(j,k) > 0
      B2(j,k,:) = gaussian_prob(data, mu(:,j,k), Sigma(:,:,j,k));
      %end
    end
  end
end

% B(j,t) = sum_k B2(j,k,t) * Pr(M(t)=k | Q(t)=j) 

% The repmat is actually slower than the for-loop, because it uses too much memory
% (this is true even for small T).

%B = squeeze(sum(B2 .* repmat(mixmat, [1 1 T]), 2));
%B = reshape(B, [Q T]); % undo effect of squeeze in case Q = 1
  
B = zeros(Q,T);
if Q < T
  for q=1:Q
    %B(q,:) = mixmat(q,:) * squeeze(B2(q,:,:)); % squeeze chnages order if M=1
    B(q,:) = mixmat(q,:) * permute(B2(q,:,:), [2 3 1]); % vector * matrix sums over m
  end
else
  for t=1:T
    B(:,t) = sum(mixmat .* B2(:,:,t), 2); % sum over m
  end
end
%t=toc;fprintf('%5.3f\n', t)

%tic
%A = squeeze(sum(B2 .* repmat(mixmat, [1 1 T]), 2));
%t=toc;fprintf('%5.3f\n', t)
%assert(approxeq(A,B)) % may be false because of round off error
