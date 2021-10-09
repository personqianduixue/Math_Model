function [muX, SXX] = marginalize_gaussian(mu, Sigma, X, Y, ns)
% MARGINALIZE_GAUSSIAN Compute Pr(X) from Pr(X,Y) where X and Y are jointly Gaussian.
% [muX, SXX] = marginalize_gaussian(mu, Sigma, X, Y, ns)

[muX, muY, SXX, SXY, SYX, SYY] = partition_matrix_vec(mu, Sigma, X, Y, ns);


