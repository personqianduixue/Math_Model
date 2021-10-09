function [A,C] = est_transmat(seq)
% ESTIMATE_TRANSMAT Max likelihood of a Markov chain transition matrix
% [A,C] = estimate_transmat(seq)
%
% seq is a vector of positive integers
%
% e.g., seq = [1 2 1 2 3], C(1,2)=2, C(2,1)=1, C(2,3)=1, so
% A(1,:)=[0 1 0], A(2,:) = [0.5 0 0.5],
% all other entries are 0

% Use a trick with sparse matrices to count the number of each transition.
% From http://www.mathworks.com/company/newsletter/may03/dna.shtml

C = full(sparse(seq(1:end-1), seq(2:end),1));
A = mk_stochastic(C);
