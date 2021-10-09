function sz = mysize(M)
% MYSIZE Like the built-in size, except it returns n if M is a vector of length n, and 1 if M is a scalar.
% sz = mysize(M)
% 
% The behavior is best explained by examples
% - M = rand(1,1),   mysize(M) = 1,      size(M) = [1 1]
% - M = rand(2,1),   mysize(M) = 2,      size(M) = [2 1]
% - M = rand(1,2),   mysize(M) = 2,      size(M) = [1 2]
% - M = rand(2,2,1), mysize(M) = [2 2],  size(M) = [2 2]
% - M = rand(1,2,1), mysize(M) = 2,      size(M) = [1 2]

if isvector(M)
  sz = length(M);
else
  sz = size(M);
end
