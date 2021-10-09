function M = rand_psd(d, d2, k)
% Create a random positive definite matrix of size d by d by k (k defaults to 1)
% M = rand_psd(d, d2, k)   default: d2 = d, k = 1

if nargin<2, d2 = d; end
if nargin<3, k = 1; end
if d2 ~= d, error('must be square'); end

M = zeros(d,d,k);
for i=1:k
  A = rand(d);
  M(:,:,i) = A*A';
end
