function p = matrix_T_pdf(A, M, V, K, n)
% MATRIX_T_PDF Evaluate the density of a matrix under a Matrix-T distribution
% p = matrix_T_pdf(A, M, V, K, n)

% See "Bayesian Linear Regression", T. Minka, MIT Tech Report, 2001

[d m] = size(K);
is = 1:d;
c1 = prod(gamma((n+1-is)/2)) / prod(gamma((n-m+1-is)/2));
c2 = det(K)^(d/2) / det(pi*V)^(m/2); %% pi or 2pi?
p = c1 * c2 * det((A-M)'*inv(V)*(A-M)*K + eye(m))^(-n/2);

