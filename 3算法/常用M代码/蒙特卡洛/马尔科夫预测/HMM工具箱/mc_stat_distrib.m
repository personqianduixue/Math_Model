function pi = mc_stat_distrib(P)
% MC_STAT_DISTRIB Compute stationary distribution of a Markov chain
% function pi = mc_stat_distrib(P)
% 
% Each row of P should sum to one; pi is a column vector

% Kevin Murphy, 16 Feb 2003

% The stationary distribution pi satisfies pi P = pi
% subject to sum_i pi(i) = 1,  0 <= pi(i) <= 1
% Hence
% (P'  0n   (pi  = (pi 
%  1n  0)    1)     1)
% or P2 pi2 = pi2.
% Naively we can solve this using (P2 - I(n+1)) pi2 = 0(n+1)
% or P3 pi2 = 0(n+1), i.e., pi2 = P3 \ zeros(n+1,1)
% but this is singular (because of the sum-to-one constraint).
% Hence we replace the last row of P' with 1s instead of appending ones to create P2, 
% and similarly for pi.

n = length(P);
P4 = P'-eye(n);
P4(end,:) = 1;
pi = P4 \ [zeros(n-1,1);1];


