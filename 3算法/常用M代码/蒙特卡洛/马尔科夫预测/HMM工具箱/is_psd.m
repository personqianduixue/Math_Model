function b = positive_semidefinite(M)
%
% Return true iff v M v' >= 0 for any vector v.
% We do this by checking that all the eigenvalues are non-negative.

E = eig(M);
if length(find(E>=0)) == length(E)
  b = 1;
else
  b = 0;
end
