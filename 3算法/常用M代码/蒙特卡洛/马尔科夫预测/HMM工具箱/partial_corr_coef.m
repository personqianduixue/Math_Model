function [r, c] = partial_corr_coef(S, i, j, Y)
% PARTIAL_CORR_COEF Compute a partial correlation coefficient
% [r, c] = partial_corr_coef(S, i, j, Y)
%
% S is the covariance (or correlation) matrix for X, Y, Z
% where X=[i j], Y is conditioned on, and Z is marginalized out.
% Let S2 = Cov[X | Y] be the partial covariance matrix.
% Then c = S2(i,j) and r = c / sqrt( S2(i,i) * S2(j,j) ) 
%

% Example: Anderson (1984) p129
% S = [1.0 0.8 -0.4;
%     0.8 1.0 -0.56;
%     -0.4 -0.56 1.0];
% r(1,3 | 2) = 0.0966 
%
% Example: Van de Geer (1971) p111
%S = [1     0.453 0.322;
%     0.453 1.0   0.596;
%     0.322 0.596 1];
% r(2,3 | 1) = 0.533

X = [i j];
i2 = 1; % find_equiv_posns(i, X);
j2 = 2; % find_equiv_posns(j, X);
S2 = S(X,X) - S(X,Y)*inv(S(Y,Y))*S(Y,X);
c = S2(i2,j2);
r = c / sqrt(S2(i2,i2) * S2(j2,j2));
