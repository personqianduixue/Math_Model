function p = matrix_normal_pdf(A, M, V, K)
% MATRIX_NORMAL_PDF Evaluate the density of a matrix under a Matrix-Normal distribution
% p = matrix_normal_pdf(A, M, V, K)

% See "Bayesian Linear Regression", T. Minka, MIT Tech Report, 2001

[d m] = size(K);
c = det(K)^(d/2) / det(2*pi*V)^(m/2);
p = c * exp(-0.5*tr((A-M)'*inv(V)*(A-M)*K));
