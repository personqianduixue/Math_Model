function L = log_student_pdf(X, mu, lambda, alpha)
% LOG_STUDENT_PDF Evaluate the log of the multivariate student-t distribution at a point
% L = log_student_pdf(X, mu, lambda, alpha)
%
% Each column of X is evaluated.
% See Bernardo and Smith p435.

k = length(mu);
assert(size(X,1) == k);
[k N] = size(X);
logc = gammaln(0.5*(alpha+k)) - gammaln(0.5*alpha) - (k/2)*log(alpha*pi) + 0.5*log(det(lambda));
middle = (1 + (1/alpha)*(X-mu)'*lambda*(X-mu)); % scalar version
L = logc - ((alpha+k)/2)*log(middle);
