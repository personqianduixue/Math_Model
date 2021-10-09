function p = student_t_pdf(X, mu, lambda, alpha)
% STUDENT_T_PDF Evaluate the multivariate student-t distribution at a point
% p = student_t_pdf(X, mu, lambda, alpha)
%
% Each column of X is evaluated.
% See Bernardo and Smith p435.

k = length(mu);
assert(size(X,1) == k);
[k N] = size(X);
numer = gamma(0.5*(alpha+k));
denom = gamma(0.5*alpha) * (alpha*pi)^(k/2);
c = (numer/denom) * det(lambda)^(0.5);
p = c*(1 + (1/alpha)*(X-mu)'*lambda*(X-mu))^(-(alpha+k)/2); % scalar version
%m = repmat(mu(:), 1, N);
%exponent = sum((X-m)'*lambda*(X-m), 2); % column vector
%p = c*(1 + (1/alpha)*exponent).^(-(alpha+k)/2);

keyboard
