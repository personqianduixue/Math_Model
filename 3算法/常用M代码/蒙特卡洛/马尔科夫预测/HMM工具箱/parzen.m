function [B,B2,dist] = parzen(data, mu, Sigma, N)
% EVAL_PDF_COND_PARZEN Evaluate the pdf of a conditional Parzen window
% function B = eval_pdf_cond_parzen(data, mu, Sigma, N)
%
% B(q,t) = Pr(data(:,t) | Q=q) = sum_{m=1}^{N(q)} w(m,q)*K(data(:,t) - mu(:,m,q); sigma)
% where K() is a Gaussian kernel with spherical variance sigma,
% and w(m,q) = 1/N(q) if m<=N(q) and = 0 otherwise
% where N(q) is the number of mxiture components for q 
%
% B2(m,q,t) =  K(data(:,t) - mu(:,m,q); sigma) for m=1:max(N)

% This is like eval_pdf_cond_parzen, except mu is mu(:,m,q) instead of mu(:,q,m)
% and we use 1/N(q) instead of mixmat(q,m)

if nargout >= 2
  keep_B2 = 1;
else
  keep_B2 = 0;
end

if nargout >= 3
  keep_dist = 1;
else
  keep_dist = 0;
end

[d M Q] = size(mu);
[d T] = size(data);

M = max(N(:));

B = zeros(Q,T);
const1 = (2*pi*Sigma)^(-d/2);
const2 = -(1/(2*Sigma));
if T*Q*M>20000000 % not enough memory to call sqdist
  disp('eval parzen for loop')
  if keep_dist,
    dist = zeros(M,Q,T);
  end
  if keep_B2
    B2 = zeros(M,Q,T);
  end
  for q=1:Q
    D = sqdist(mu(:,1:N(q),q), data); % D(m,t)
    if keep_dist
      dist(:,q,:) = D;
    end
    tmp = const1 * exp(const2*D);
    if keep_B2,
      B2(:,q,:) = tmp;
    end
    if N(q) > 0
      %B(q,:) = (1/N(q)) * const1 * sum(exp(const2*D), 2);
      B(q,:) = (1/N(q)) * sum(tmp,1);
    end
  end
else
  %disp('eval parzen vectorized')
  dist = sqdist(reshape(mu(:,1:M,:), [d M*Q]), data); % D(mq,t)
  dist = reshape(dist, [M Q T]);
  B2 = const1 * exp(const2*dist); % B2(m,q,t)
  if ~keep_dist
    clear dist
  end
  
  % weights(m,q) is the weight of mixture component m for q  
  %    = 1/N(q) if m<=N(q) and = 0 otherwise
  % e.g., N = [2   3   1], M = 3,
  % weights = [1/2 1/3 1   = 1/2 1/3 1/1      2 3 1     1 1 1
  %            1/2 1/3 0     1/2 1/3 1/1 .*   2 3 1 <=  2 2 2
  %            0   1/3 0]    1/2 1/3 1/1      2 3 1     3 3 3
   
  Ns = repmat(N(:)', [M 1]);
  ramp = 1:M;
  ramp = repmat(ramp(:), [1 Q]);
  n = N + (N==0); % avoid 1/0 by replacing with 0* 1/1m where 0 comes from mask
  N1 = repmat(1 ./ n(:)', [M 1]);
  mask = (ramp <= Ns);
  weights = N1 .* mask;
  B2 = B2 .* repmat(mask, [1 1 T]);
  
  % B(q,t) = sum_m B2(m,q,t) * P(m|q) = sum_m B2(m,q,t) * weights(m,q)
  B = squeeze(sum(B2 .* repmat(weights, [1 1 T]), 1)); 
  B = reshape(B, [Q T]); % undo effect of squeeze in case Q = 1
end

  

