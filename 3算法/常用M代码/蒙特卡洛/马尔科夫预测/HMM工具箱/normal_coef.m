function c = normal_coef (Sigma)
% NORMAL_COEF Compute the normalizing coefficient for a multivariate gaussian.
% c = normal_coef (Sigma)

n = length(Sigma);
c = (2*pi)^(-n/2) * det(Sigma)^(-0.5);

