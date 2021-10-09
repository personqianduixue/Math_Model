function U = unaryEncoding(data, K)
% unaryEncoding Encode data(s) as a 1-of-K column vector
% function U = unaryEncoding(data, K)
%
% eg.
% If data = [3 2 2] and K=3,
% then U = [0 0 0
%           0 1 1
%           1 0 0]

if nargin < 2, K = max(data); end
N = length(data);
U = zeros(K,N);
ndx = subv2ind([K N], [data(:)'; 1:N]');
U(ndx) = 1;
U = reshape(U, [K N]);
