function M = softeye(K, p)
% SOFTEYE Make a stochastic matrix with p on the diagonal, and the remaining mass distributed uniformly
% M = softeye(K, p)
%
% M is a K x K matrix.

M = p*eye(K);
q = 1-p;
for i=1:K
  M(i, [1:i-1  i+1:K]) = q/(K-1);
end
